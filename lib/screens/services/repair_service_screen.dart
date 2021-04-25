import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/home/cubit/home_cubit.dart';
import 'package:flutter_map_booking/screens/services/cubit/service_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/app_bar_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/card_service_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/modal_select_service_widget.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class RepairServiceScreen extends CubitWidget<HomeCubit, HomeState> {
  final int idService;
  final List<ServicesResponse> listServices;
  final bool navigationBooking;

  RepairServiceScreen(this.idService,
      {this.listServices, this.navigationBooking = false});

  static provider(int idService,
      {List<ServicesResponse> listServices, bool navigationBooking}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ServiceCubit>(
          create: (context) => ServiceCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ],
      child: RepairServiceScreen(
        idService,
        listServices: listServices ?? [],
        navigationBooking: navigationBooking,
      ),
    );
  }

  final tripService = locator<TripService>();

  @override
  void listener(BuildContext context, HomeState state) async {
    // TODO: implement listener
    super.listener(context, state);
    if (state is HomeFetchingData) {
      if (navigationBooking) {
        final response = tripService.getRequestCheckResponse;
        final status = tripService.getStatus;
        final listParent = state.listServices;
        final listChild = listParent[
                listParent.indexWhere((element) => element.id == idService)]
            .childrenRecursive;
        final index = listChild.indexWhere(
            (element) => element.id == response.data.first.serviceType.id);
        await Future.delayed(Duration(milliseconds: 700));
        handleNavigation(
            response, status, index, context, listChild, listParent);
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (listServices.length > 0) {
      bloc.copyData(listServices);
    } else {
      bloc.fetchingData();
    }
  }

  @override
  Widget builder(BuildContext context, state) {
    final listService = state.listServices;
    return Scaffold(
      appBar: buildAppbar(context, listService),
      body: Container(
        color: Colors.white,
        child: SizedBox.expand(
          child: buildListView(listService),
        ),
      ),
    );
  }

  buildListView(List<ServicesResponse> services) {
    List<ServicesResponse> listChild;
    if (services.length > 0) {
      listChild =
          services[services.indexWhere((element) => element.id == idService)]
              .childrenRecursive;
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: listChild == null ? 2 : listChild.length,
      itemBuilder: (context, index) {
        return listChild == null
            ? Container(
                width: double.infinity,
                height: 150.0,
                child: Center(child: CircularProgressIndicator()))
            : CardServiceWidget(
                disable: navigationBooking,
                showTextForm: true,
                onPress: () async {
                  final response = tripService.getRequestCheckResponse;
                  final status = tripService.getStatus;
                  final listParent = bloc.state.listServices;
                  if (listChild.length > 0) {
                    handleNavigation(response, status, index, context,
                        listChild, listParent);
                  } else {
                    bloc.showDialog(
                        title: 'glink_work'.tr, description: 'server_error'.tr);
                  }
                },
                moneyText: listChild[index].price ?? "",
                subTitleText: listChild[index].description ?? "",
                titleText: listChild[index].name ?? "",
                urlImage: listChild[index].image ?? "",
              );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 1.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xffE1E1E1)),
            ),
          ),
        );
      },
    );
  }

  void showModal(BuildContext context, ServicesResponse item) {
    final cubit = context.bloc<ServiceCubit>();
    final paddingHorizontal = 15.0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: ModalSelectService(
            paddingHorizontal: paddingHorizontal,
            item: item,
          ),
        );
      },
    ).whenComplete(() async {
      Future.delayed(Duration(milliseconds: 400), () {
        cubit.refreshInit();
      });
    });
  }

  buildAppbar(BuildContext context, List<ServicesResponse> listParent) {
    String title = "";
    if (listParent.length > 0) {
      title = listParent[
              listParent.indexWhere((element) => element.id == idService)]
          .name;
    }
    return PreferredSize(
      child: AppbarWidget(
        text: title,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  void handleNavigation(
      RequestCheckResponse response,
      String status,
      int index,
      BuildContext context,
      List<ServicesResponse> listChild,
      List<ServicesResponse> listParent) {
    if (response.data != null &&
        response.data.length > 0 &&
        status != TripStatus.EMPTY) {
      if (response.data.first.serviceTypeId != listChild[index].id) {
        bloc
            .showDialog(
          barrierDismissible: true,
          title: 'glink_work'.tr,
          description:
              'you_are_booking_a_service_so_complete_it_before_choosing_another_service'
                  .tr,
        )
            .whenComplete(() {
          int indexChild = -1;
          final indexServiceBook = listParent.indexWhere((element) {
            final indexCheck = element.childrenRecursive.indexWhere((element) {
              if (element.id == response.data.first.serviceTypeId) {
                return true;
              }
              return false;
            });
            print(indexCheck);
            if (indexCheck > -1) {
              indexChild = indexCheck;
              return true;
            }
            return false;
          });

          if (indexChild > -1 && indexServiceBook > -1) {
            if (navigationBooking) {
              Navigator.of(context)
                  .popAndPushNamed(AppRoute.bookingScreen, arguments: {
                'service':
                    listParent[indexServiceBook].childrenRecursive[indexChild]
              });
            } else {
              Navigator.of(context)
                  .pushNamed(AppRoute.bookingScreen, arguments: {
                'service':
                    listParent[indexServiceBook].childrenRecursive[indexChild]
              });
            }
          }
        });
      } else {
        if (navigationBooking) {
          Navigator.of(context).popAndPushNamed(AppRoute.bookingScreen,
              arguments: {'service': listChild[index]});
        } else {
          Navigator.of(context).pushNamed(AppRoute.bookingScreen,
              arguments: {'service': listChild[index]});
        }
      }
    } else {
      if (navigationBooking) {
        Navigator.of(context).popAndPushNamed(AppRoute.bookingScreen,
            arguments: {'service': listChild[index]});
      } else {
        Navigator.of(context).pushNamed(AppRoute.bookingScreen,
            arguments: {'service': listChild[index]});
      }
    }
  }
}
