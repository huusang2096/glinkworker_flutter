import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/cancel_booking_request.dart';
import 'package:flutter_map_booking/model/cancel_reason_response.dart';
import 'package:flutter_map_booking/model/cancel_response.dart';
import 'package:flutter_map_booking/model/location_data.dart';
import 'package:flutter_map_booking/model/offer_response.dart';
import 'package:flutter_map_booking/model/place_response.dart';
import 'package:flutter_map_booking/model/rate_provider_request.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/model/schedule_service_request.dart';
import 'package:flutter_map_booking/model/search_place_request.dart';
import 'package:flutter_map_booking/model/send_request.dart';
import 'package:flutter_map_booking/model/send_request_response.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/model/show_provider_response.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_upcoming_history_response_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_wallet_response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simplest/simplest.dart';

part 'booking_state.dart';

class BookingCubit extends BaseCubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  bool autoRequestCheckOn = false;
  final tripService = locator<TripService>();
  final locatorLocationService = locator<LocationService>();
  // final firebaseDatabaseConfig = locator<FirebaseDatabaseConfig>();
  int checkPayment = 0;

  // ignore: cancel_subscriptions
  StreamSubscription streamSubscription;
  FirebaseDatabase database;
  DatabaseReference _providerRef;

  @override
  close() {
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
    tripService.isBooking = false;
    return super.close();
  }

  @override
  initData() async {
    // database = FirebaseDatabase(app: firebaseDatabaseConfig.firebaseDatabase);
    tripService.fetchRequestCheck();
    // .then((value) {
    //   if (tripService.getStatus != TripStatus.EMPTY) {
    //     autoRequestCheck();
    //   }
    // });
    tripService.isBooking = true;
    subscriptions.add(tripService.tripStream.listen((trip) {
      fetchingRequestCheck(trip);
    }));
    await setCurrentLocation();
    await setLocationIsRequestCheck();
    getUserWallet();
    getCancelReason();
  }

  _getProviderLocation(int id) async {
    if (_providerRef == null) {
      _providerRef = database.reference().child("loc_p_$id");
    }

    _providerRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data == null) {
        return;
      }
      final mapData = Map<String, dynamic>.from(data);
      final locationData = LocationData.fromJson(mapData);
      print("LOCATION_REALTIME" + locationData.bearing.toString());
      emit(BookingRealTimeProviderGGMap(locationData, state));
    });
  }

  // turnOffAutoCheck() {
  //   tripService.turnOffAutoRequestCheck();
  //   if (streamSubscription != null) {
  //     streamSubscription.cancel();
  //     streamSubscription = null;
  //   }
  // }

  // autoRequestCheck() {
  //   if (streamSubscription == null) {
  //     streamSubscription = tripService.stream.listen((data) {
  //       fetchingRequestCheck(data);
  //     });
  //   }

  //   if (tripService.isStopAutoCheck == true) {
  //     tripService.turnOnAutoRequestCheck(isBooking: true);
  //     tripService.autoRequestCheck();
  //   } else {
  //     tripService.turnOnAutoRequestCheck(isBooking: true);
  //   }
  // }

  fetchingRequestCheck(Trip data) async {
    print("boongking ${data.status}");
    switch (data.status) {
      case TripStatus.TIMEOUT:
        setDisableIsFalse();
        if (state.isShowLoadingSearch) {
          navigator.pop();
          showSearching(false);
        }
        await dialogService.showDialog(
            description: 'provider_cancel_request_please_try_again'.tr,
            title: appConfig.appName);

        changeStatusCheck(status: TripStatus.EMPTY);
        // turnOffAutoCheck();

        emit(BookingFetRequestStatusTimeout.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.CANCEL:
        emit(BookingFetRequestStatusCancel.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.ERROR:
        if (data.error != null) {
          await handleAppError(data.error);
        }
        break;
      case TripStatus.ACCEPTED:
        break;
      case TripStatus.EMPTY:
        if (state.isShowLoadingSearch) {
          navigator.pop();
          showSearching(false);
        }
        setDisableIsFalse();
        emit(BookingFetRequestStatusEmpty.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.SEARCHING:
        setDisableIsTrue();
        if (state.isShowLoadingSearch) {
          navigator.pop();
          showSearching(false);
        }
        emit(BookingFetRequestStatusSearching.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.STARTED:
        emit(BookingFetRequestStatusStarted.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        _getProviderLocation(data.id);
        break;
      case TripStatus.ARRIVED:
        emit(BookingFetRequestStatusArrived.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.PICKEDUP:
        emit(BookingFetRequestStatusPickedup.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.DROPPED:
        await checkNullPayment(data.requestCheckResponse);

        emit(BookingFetRequestStatusDropped.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.COMPLETED:
        await checkNullPayment(data.requestCheckResponse);
        emit(BookingFetRequestStatusCompleted.fetchingRequest(
            state, [], data.requestCheckResponse, data.status));
        break;
      case TripStatus.PATCH:
        break;
      case TripStatus.CANCELLED:
        break;
      case TripStatus.SCHEDULED:
        break;
      default:
        break;
    }

    // if (data.status == TripStatus.COMPLETED) {
    //   turnOffAutoCheck();
    // }
  }

  setLocationIsRequestCheck() async {
    try {
      final places = state.requestCheckResponse?.data ?? [];
      if (places.isNotEmpty) {
        final place = await getPlaceByLatLng(
            latitude: places.first.sLatitude,
            longitude: places.first.sLongitude);
        emit(BookingCurrentLocation(place, state));
      }
    } catch (e) {
      logger.e(e);
      handleAppError(e);
    }
  }

  rateProvider({int rating, String comment}) async {
    try {
      emit(BookingRateProvider(true, state));
      final requestId = state.sendRequestResponse?.requestId ?? null;
      RateProviderRequest rateProviderRequest = RateProviderRequest()
        ..comment = comment
        ..rating = rating
        ..requestId = requestId ?? state.requestCheckResponse.data.first.id;
      await dataRepository.rateProvider(rateProviderRequest);
      emit(BookingRateProvider(false, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  Future<void> sendRequest(
      {String paymentMode,
      String address,
      double latitude,
      longitude,
      int serviceType}) async {
    try {
      // dataRepository.loadAuthHeader();
      // final time = hourHMFormatter.format(state.scheduleRequest.pickTime);
      // final day = dateFormatter.format(state.scheduleRequest.pickDate);
      emit(BookingState.copyWith(isLoading: true, state: state));
      final promoCode = state.promo?.id ?? null;
      final sendRequest = SendRequest(
          paymentMode: paymentMode,
          serviceType: serviceType,
          sAddress: address,
          sLatitude: latitude,
          sLongitude: longitude,
          useWallet: state.checkUseWallet ? 1 : 0,
          promocodeId: promoCode ?? 0);
      final response = await dataRepository.sendRequest(sendRequest);
      print(response.toString());
      emit(BookingSendRequest(response, state));
      changeStatusCheck(status: TripStatus.SEARCHING);
      // autoRequestCheck();
    } catch (e) {
      handleAppError(e);
      emit(BookingNotProviderAvailable.fromState(state));
    }
    emit(BookingState.copyWith(isLoading: false, state: state));
  }

  Future<void> fetchProvidersAndRequestCheck() async {
    try {
      final response = await dataRepository.getRequestCheck();
      String statusCheck = 'EMPTY';
      if (response.data != null && response.data.length > 0) {
        statusCheck = response.data.first?.status ?? 'EMPTY';
      }

      if (state.statusCheck == 'SEARCHING' && statusCheck == 'EMPTY') {
        statusCheck = 'TIMEOUT';
      }

      print("current statusCheck : $statusCheck");
      emit(BookingFetProviderAndRequest([], response, statusCheck, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  refreshSearchPlace() {
    emit(BookingSearchPlace([], "NORMAL", state));
  }

  searchPlace(String query) async {
    try {
      emit(BookingChangeStatusSearch("SEARCH", state));
      final response = await dataRepository.searchPlace(
          language: language, region: region, key: apiKey, query: query);
      final status = response.status;
      List<Place> listPlace = Place.parseLocationList(response.toJson());

      emit(BookingSearchPlace(listPlace, status, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  Future<void> changeMyLocation(LatLng tapPoint) async {
    final place = await getPlaceByLatLng(
        latitude: tapPoint.latitude, longitude: tapPoint.longitude);

    emit(BookingChangeMyLocation(place, state));
  }

  Future<void> setCurrentLocation() async {
    try {
      await locatorLocationService.fetchLocation(askPermission: true);
      Position position = locatorLocationService.position;
      final place = await getPlaceByLatLng(
          latitude: position.latitude, longitude: position.longitude);
      emit(BookingCurrentLocation(place, state));
    } catch (e) {
      handleAppError(e);
      //logger.e(e);
    }
  }

  Future<Place> getPlaceByLatLng({double latitude, double longitude}) async {
    try {
      String latLng = latitude.toString() + "," + longitude.toString();
      Place place = new Place();
      final searchPlaceRequest = new SearchPlaceRequest(
        key: apiKey,
        language: language,
        region: region,
        latLng: latLng,
      );
      final response =
          await dataRepository.searchPlaceByLatLng(searchPlaceRequest);

      final listResults = response.results ?? [];
      if (response.results.length > 0) {
        place.formattedAddress = listResults.first.formattedAddress ?? "";
        place.lat = latitude;
        place.lng = longitude;
        place.name = listResults.first.formattedAddress ?? "";
      } else {
        place.formattedAddress = "";
        place.lat = latitude;
        place.lng = longitude;
        place.name = "";
      }
      return place;
    } catch (e) {
      handleAppError(e);
      if (state.myPlace.lat != null) {
        final place = state.myPlace;
        return Place(
            name: place.name,
            formattedAddress: place.formattedAddress,
            lat: place.lat,
            lng: place.lng);
      }
      return Place();
    }
  }

  Future<void> changeMyLocationInSearchTap(Place place) async {
    emit(BookingChangeMyLocationInSearchTap(place, state));
  }

  getSchedule(Map<String, dynamic> map) {
    final scheduleRequest = map['scheduleRequest'];
    emit(BookingSchedule(scheduleRequest, state));
  }

  changeIsDisableBooking(bool isDisableBooking) {
    emit(BookingDisableBooking(isDisableBooking, state));
  }

  changeIsDisableGGMap(bool isDisableGGMap) {
    emit(BookingDisableGGMap(isDisableGGMap, state));
  }

  changeIsDisableDetailAddress(bool isDisableDetailAddress) {
    emit(BookingDisableDetailAddress(isDisableDetailAddress, state));
  }

  changeIsDisablePanel(bool isDisablePanel) {
    emit(BookingDisablePanel(isDisablePanel, state));
  }

  showSearching(bool isShow) {
    emit(BookingShowLoadingSearch(isShow, state));
  }

  makeCall(String number) {
    return dataRepository.makePhoneCall(number);
  }

  updateRatingRequest(String comment, int rating) {
    RateProviderRequest ratingRequest;
    if (rating == null) {
      ratingRequest = RateProviderRequest(
          rating: state.ratingRequest.rating, comment: comment);
    } else {
      ratingRequest = RateProviderRequest(
          rating: rating, comment: state.ratingRequest.comment);
    }

    emit(BookingUpdateRatingRequest(ratingRequest, state));
  }

  changeStatusCheck({String status}) {
    if (status == TripStatus.CANCEL) {
      // turnOffAutoCheck();
      emit(BookingFetRequestStatusCancel.fetchingRequest(
          state, [], state.requestCheckResponse, status));
      return;
    }
    if (status == TripStatus.EMPTY) {
      tripService.changeStatus(TripStatus.EMPTY);
      emit(BookingFetRequestStatusEmpty.fetchingRequest(
          state, [], state.requestCheckResponse, status));
      return;
    }
    if (status == TripStatus.SEARCHING) {
      tripService.changeStatus(TripStatus.SEARCHING);
      return;
    }
    emit(BookingFetProviderAndRequest(
        [], state.requestCheckResponse, state.statusCheck, state));
  }

  handleMaxHeight(Size size, String statusCheck) {
    var maxHeight = 0.0;

    switch (statusCheck) {
      case TripStatus.CANCEL:
        maxHeight = size.height * 0.3;
        break;
      case TripStatus.EMPTY:
        maxHeight = size.height * 0.30;
        break;
      case TripStatus.SEARCHING:
        maxHeight = size.height * 0.28;
        break;
      case TripStatus.DROPPED:
        maxHeight = size.height * 0.75;
        break;
      case TripStatus.COMPLETED:
        maxHeight = size.height * 0.40;
        break;
      default:
        maxHeight = size.height * 0.35;
        break;
    }

    maxHeight += 80;
    return maxHeight;
  }

  // handleDismissCancelRequest() {
  //   autoRequestCheck();
  // }

  updateCancelRequest(String reason) {
    emit(BookingCancelReason(
        CancelBookingRequest(
            requestId: state.cancelRequest.requestId, cancelReason: reason),
        state));
  }

  submitReasonCancel() async {
    try {
      emit(BookingState.copyWith(isDisablePanel: true, state: state));
      int requestId = state.sendRequestResponse?.requestId;
      final requestIdInRequestCheck = state.requestCheckResponse?.data != null
          ? state.requestCheckResponse.data.first
          : null;
      if (requestId == null && requestIdInRequestCheck == null) {
        // final responseDialog = await dialogService.showDialog(
        //     description: 'server_error_please_try_again'.tr,
        //     title: appConfig.appName);
        emit(BookingState.copyWith(isDisablePanel: false, state: state));
        return;
      }

      if (requestId == null) {
        requestId = requestIdInRequestCheck.id;
      }

      final cancelRequest = CancelBookingRequest(
          requestId: requestId, cancelReason: state.cancelRequest.cancelReason);
      final response = await dataRepository.cancelBooking(cancelRequest);
      // turnOffAutoCheck();
      emit(BookingCancelSuccess(state, response));
    } catch (e) {
      handleAppError(e);
    }
    emit(BookingState.copyWith(isDisablePanel: false, state: state));
  }

  handleTapGGMap(LatLng tapPoint) async {
    if (!state.isDisableGGMap) {
      await Future.delayed(Duration(milliseconds: 300));
      await changeMyLocation(tapPoint);
    }
  }

  setDisableIsFalse() {
    if (state.isDisableDetailAddress == true) {
      changeIsDisableDetailAddress(false);
    }
    if (state.isDisableGGMap == true) {
      changeIsDisableGGMap(false);
    }
  }

  setDisableIsTrue() {
    if (state.isDisableDetailAddress == false) {
      changeIsDisableDetailAddress(true);
    }
    if (state.isDisableGGMap == false) {
      changeIsDisableGGMap(true);
    }
  }

  handleCreatedMap() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      changeIsDisableBooking(false);
    });
  }

  scheduleServiceBook(ServicesResponse service,
      {String paymentMode,
      String address,
      double latitude,
      longitude,
      int serviceType}) async {
    final int promoCode = state.promo?.id ?? null;
    final sendRequest = SendRequest(
      paymentMode: paymentMode,
      serviceType: serviceType,
      sAddress: address,
      sLatitude: latitude,
      sLongitude: longitude,
      useWallet: state.checkUseWallet ? 1 : 0,
      promocodeId: promoCode ?? 0,
    );
    await navigator.pushNamed(AppRoute.bookTimeServiceScreen, arguments: {
      'item': service,
      'amount': 1,
      'ton': '1 TON',
      'sendRequest': sendRequest
    });
    //if (requestPop != null) getSchedule(requestPop as Map<String, dynamic>);
  }

  changeSelectPayment(int index) {
    emit(BookingSelectPayment(index, state));
  }

  getPromo() async {
    final requestPop = await navigator
        .pushNamed(AppRoute.offerScreen, arguments: {'disable': false});

    if (requestPop != null) {
      final promo = requestPop as Map<String, dynamic>;
      emit(BookingSelectPromo(promo['promo'], state));
    }
  }

  getUpComingTrip() async {
    try {
      final upcoming = await dataRepository.getUserRequesUpcomingHistory();
      final data = upcoming ?? [];
      if (data.length > 0) {
        emit(BookingUpComingTrip(upcoming, state));
      }
    } catch (err) {
      handleAppError(err);
    }
  }

  removePromo() {
    emit(BookingSelectPromo(PromoList(), state));
  }

  Future<bool> changeUseWallet() async {
    final bool = !state.checkUseWallet;
    if (state.userWallet?.walletBalance != null) {
      if (state.userWallet.walletBalance == 0) {
        return false;
      }
    } else {
      return null;
    }
    emit(BookingChangeUseWallet(bool, state.userWallet, state));
    return true;
  }

  getUserWallet() async {
    try {
      final userWallet = await dataRepository.getUserWallet();
      if (userWallet != null) {
        emit(BookingChangeUseWallet(state.checkUseWallet, userWallet, state));
      } else {
        showErrorMessage('wallet_error');
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  /// Header Actions: SOS, Chat, Calling
  onSelectSOS() async {
    final url = 'tel:$kSupportNumber';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      logger.e('Can not launch url $url');
    }
  }

  onSelectCalling() async {
    final _currentTrip = tripService.currentTrip;
    if (_currentTrip == null) {
      return;
    }
    final _provider = _currentTrip.provider;
    final url = 'tel:${_provider.countryCode}${_provider.mobile}';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      logger.e('Can not launch url $url');
    }
  }

  onSelectChat() {
    final _currentTrip = tripService.currentTrip;
    if (_currentTrip == null) {
      return;
    }
    navigator.pushNamed(AppRoute.chatScreen, arguments: {'trip': _currentTrip});
  }

  checkNullPayment(RequestCheckResponse data) async {
    if (tripService.currentTrip == null) {
      final response = await dialogService.showDialog(
          description:
              'payment_errors_please_try_again_or_contact_management_for_assistance'
                  .tr,
          title: appConfig.appName);
      return;
    }
    bool result = false;
    if (data.data.first.payment == null) {
      checkPayment++;
    }
    if (checkPayment == 5) {
      result = true;
      checkPayment = 0;
    }
    if (result) {
      // turnOffAutoCheck();
      final response = await dialogService.showDialog(
          description:
              'payment_errors_please_try_again_or_contact_management_for_assistance'
                  .tr,
          title: appConfig.appName);
      if (response.confirmed) {
        // autoRequestCheck();
      }
    }
  }

  getCancelReason() async {
    try {
      final cancelReason = await dataRepository.getListCancelReason();
      emit(BookingGetCancelReason(cancelReason, state));
    } catch (e) {
      logger.e(e);
    }
  }

  selectCancelReason(int index) {
    emit(SelectCancelReason(index, state));
  }
}
