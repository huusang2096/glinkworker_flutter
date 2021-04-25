import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/location_data.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/module/google_maps/util.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/booking/widgets/detail_address_widget.dart';
import 'package:flutter_map_booking/screens/booking/widgets/sliding_up_panel_widget.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simplest/simplest.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookingScreen extends CubitWidget<BookingCubit, BookingState> {
  final ServicesResponse service;

  BookingScreen(this.service);

  static provider(ServicesResponse service) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: BookingScreen(service),
    );
  }

  final tripService = locator<TripService>();

  Completer<GoogleMapController> _controller = Completer();

  PanelController _panelController = PanelController();

  // for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor bitmapDescriptorSource, bitmapDescriptorDes;

  @override
  void afterFirstLayout(BuildContext context) async {
    //set icon map;
    bitmapDescriptorSource =
        await createBitmapDescriptor(context, "assets/images/ic_marker_48.png");
    bitmapDescriptorDes = await createBitmapDescriptor(
        context, "assets/images/mark_worker_2.png",
        width: 140);
  }

  @override
  void listener(BuildContext context, BookingState state) async {
    super.listener(context, state);

    if (state is BookingFetRequestStatusTimeout) {}
    if (state is BookingFetRequestStatusEmpty) {
      clearPolylines();
    }
    if (state is BookingFetRequestStatusSearching) {}
    if (state is BookingFetRequestStatusStarted ||
        state is BookingFetRequestStatusArrived ||
        state is BookingFetRequestStatusPickedup ||
        state is BookingFetRequestStatusDropped ||
        state is BookingFetRequestStatusCompleted) {
      if (bloc.state.isShowLoadingSearch) {
        Navigator.of(context).pop();
        bloc.showSearching(false);
      }
      if (_polylines.isEmpty) {
        if (bloc.state.myPlace?.lat != null) {
          await setPolylines();
        }
      }
      bloc.setDisableIsTrue();
      addMarkerSource(status: state.statusCheck);
      addMarkerDes(status: state.statusCheck);
    }

    if (state is BookingNotProviderAvailable) {
      if (bloc.state.isShowLoadingSearch) {
        Navigator.of(context).pop();
        bloc.showSearching(false);
      }
    }

    if (state is BookingChangeMyLocationInSearchTap) {
      await addMarkerSource();
      _goToPosition(LatLng(state.myPlace.lat, state.myPlace.lng));
    }

    if (state is BookingChangeMyLocation) {
      await addMarkerSource();
    }

    if (state is BookingCurrentLocation) {
      await addMarkerSource();
      if (bloc.state.myPlace?.lat != null) {
        _goToPosition(LatLng(state.myPlace.lat, state.myPlace.lng));
      }
    }

    if (state is BookingRealTimeProviderGGMap) {
      updateMarkerDes(state.locationData);
    }

    if (state is BookingRateProvider) {
      bloc
          .showDialog(
              barrierDismissible: false,
              description:
                  'submit_successfully_click_ok_to_return_to_the_services'.tr)
          .whenComplete(() {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoute.tabScreen, (route) => false);
      });
    }

    if (state is BookingCancelSuccess) {
      // final dialogResponse = await bloc.showDialog(
      //     barrierDismissible: false,
      //     description: '${state.cancelResponse.message}'.tr);
      // if (dialogResponse.confirmed) {
      bloc.changeStatusCheck(status: TripStatus.EMPTY);
      // }
    }
  }

  @override
  Widget builder(BuildContext context, BookingState state) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: AbsorbPointer(
          absorbing: bloc.state.isDisableBooking,
          child: Stack(
            children: [
              state.myPlace.lng != null
                  ? buildGoogleMap()
                  : buildLoadingContent(),
              DetailAddress(
                isDisable: state.isDisableDetailAddress,
                size: size,
                state: state,
                onPressLocation: () async {
                  await bloc.setCurrentLocation();
                },
                onPressAddress: () {
                  Navigator.of(context).pushNamed(AppRoute.searchPlaceScreen,
                      arguments: {'cubit': bloc});
                },
              ),
              SlidingUpPanelWidget(
                  service: service, panelController: _panelController),
            ],
          ),
        ),
      ),
    );
  }

  clearPolylines() {
    final MarkerId markerIdDes = MarkerId("desPin");
    _polylines.clear();
    markers.removeWhere((key, value) => key == markerIdDes);
  }

  Future<void> _goToPosition(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //target: LatLng(37.42796133580664, -122.085749655962),
          target: latLng,
          zoom: 16,
        ),
      ),
    );
  }

  buildGoogleMap() {
    return GoogleMap(
      // onCameraIdle: () {
      //   if (_panelController.isAttached) if (_panelController.isPanelClosed)
      //     _panelController.open();
      // },
      // onCameraMoveStarted: () {
      //   if (_panelController.isAttached) if (_panelController.isPanelOpen)
      //     _panelController.close();
      // },
      onTap: (tapPoint) {
        bloc.handleTapGGMap(tapPoint);
      },
      markers: Set<Marker>.of(markers.values),
      mapType: MapType.normal,
      polylines: _polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(bloc.state.myPlace.lat, bloc.state.myPlace.lng),
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) async {
        _controller.complete(controller);
        bloc.handleCreatedMap();
      },
    );
  }

  buildLoadingContent() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> addMarkerSource({String status}) async {
    if (bloc.state.myPlace?.lat != null) {
      final MarkerId markerIdSource = MarkerId("sourcePin");
      final Marker marker = Marker(
        markerId: markerIdSource,
        icon: bitmapDescriptorSource,
        position: LatLng(bloc.state.myPlace.lat, bloc.state.myPlace.lng),
      );
      markers[markerIdSource] = marker;
    }
  }

  Future<void> addMarkerDes({String status}) async {
    final MarkerId markerIdDes = MarkerId("desPin");
    final Marker markerDes = Marker(
      markerId: markerIdDes,
      icon: bitmapDescriptorDes,
      position: LatLng(
          bloc.state.requestCheckResponse.data.first.provider?.latitude ?? 0.0,
          bloc.state.requestCheckResponse.data.first.provider?.longitude ??
              0.0),
    );
    markers[markerIdDes] = markerDes;
  }

  Future<void> updateMarkerDes(LocationData locationData) async {
    final MarkerId markerIdDes = MarkerId("desPin");
    final Marker markerDes = Marker(
      markerId: markerIdDes,
      icon: bitmapDescriptorDes,
      position: LatLng(locationData.lat ?? 0.0, locationData.lng ?? 0.0),
      draggable: false,
      rotation: locationData.bearing,
      anchor: Offset(0.5, 0.5),
    );
    markers[markerIdDes] = markerDes;
  }

  Future<void> setPolylines() async {
    final data = bloc.state.requestCheckResponse?.data ?? [];
    if (data.length > 0 && data.first.provider != null) {
      final first = bloc.state.requestCheckResponse.data.first;

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(bloc.state.myPlace.lat, bloc.state.myPlace.lng),
        PointLatLng(first.provider.latitude, first.provider.longitude),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        final PolylineId polylineIdSource = PolylineId("pin");
        final Polyline polylineSource = Polyline(
            width: 5, // set the width of the polylines
            polylineId: polylineIdSource,
            color: Colors.redAccent,
            points: polylineCoordinates);

        _polylines.add(polylineSource);
      }
    }
  }

  @override
  dispose() {
    _controller.future
        .then((value) => value.dispose())
        .then((_) => super.dispose());
  }
}
