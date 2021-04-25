import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_map_booking/common/storage/app_prefs.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/base_response.dart';
import 'package:flutter_map_booking/model/cancel_booking_request.dart';
import 'package:flutter_map_booking/model/cancel_reason_response.dart';
import 'package:flutter_map_booking/model/cancel_response.dart';
import 'package:flutter_map_booking/model/dispute_response.dart';
import 'package:flutter_map_booking/model/forgot_password_request.dart';
import 'package:flutter_map_booking/model/login_request.dart';
import 'package:flutter_map_booking/model/login_response.dart';
import 'package:flutter_map_booking/model/notification_response.dart';
import 'package:flutter_map_booking/model/offer_response.dart';
import 'package:flutter_map_booking/model/profile_response.dart';
import 'package:flutter_map_booking/model/rate_provider_request.dart';
import 'package:flutter_map_booking/model/rate_provider_response.dart';
import 'package:flutter_map_booking/model/register_request.dart';
import 'package:flutter_map_booking/model/register_response.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/model/search_place_by_latlng_response.dart';
import 'package:flutter_map_booking/model/search_place_request.dart';
import 'package:flutter_map_booking/model/search_place_response.dart';
import 'package:flutter_map_booking/model/send_request.dart';
import 'package:flutter_map_booking/model/send_request_response.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/model/show_provider_response.dart';
import 'package:flutter_map_booking/model/update_language_response.dart';
import 'package:flutter_map_booking/network/google_client.dart';
import 'package:flutter_map_booking/network/rest_client.dart';
import 'package:flutter_map_booking/screens/order_history/models/dispute_list_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/past_trip_detail_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/report_item_request_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/upcoming_trip_detail_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_dispute_request_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_upcoming_history_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_history_response_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_add_money_request_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_card_response_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_wallet_response_model.dart';
import 'package:logger/logger.dart';
import 'package:simplest/simplest.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class DataRepository {
  final logger = Logger();
  final dio = Dio();
  RestClient _client;
  GoogleClient _googleClient;

  DataRepository() {
    dio.interceptors
      ..add(LogInterceptor(requestBody: false, responseBody: false));
    _client = RestClient(dio);
    _googleClient = GoogleClient(dio);
    loadAuthHeader();
  }

  void loadAuthHeader() async {
    final _appPref = locator<AppPref>();
    dio.options.headers["X-Requested-With"] = "XMLHttpRequest";
    dio.options.headers["Authorization"] = _appPref.token;
    dio.options.headers["Accept-Language"] = _appPref.langCode;
    log('access token ${_appPref.token}');
  }

  Future<LoginResponse> login(LoginRequest request) async {
    return _client.login(request: request);
  }

  Future<void> logout({String userId}) async {
    return _client.logout(userId: userId);
  }

  Future<ProfileResponse> getProfile() {
    return _client.getProfile();
  }

  Future<ProfileResponse> updateProfile(
      {String mobile,
      String countryCode,
      String lastName,
      String firstName,
      String email,
      File picture}) {
    return _client.updateProfile(
        mobile: mobile,
        countryCode: countryCode,
        lastName: lastName,
        firstName: firstName,
        email: email,
        picture: picture);
  }

  Future<RegisterResponse> loginOrRegister(
      RegisterRequest registerRequest) async {
    return _client.loginOrRegister(registerRequest);
  }

  Future<void> resetPassword(ForgotPasswordRequest forgotPassRequest) async {
    return _client.resetPassword(forgotPassRequest);
  }

  Future<List<UserRequestHistoryResponse>> getUserRequesPasttHistory() {
    return _client.getUserRequestPastHistory();
  }

  Future<List<UserRequestUpcomingHistoryResponse>>
      getUserRequesUpcomingHistory() {
    return _client.getUserRequestUpcomingHistory();
  }

  Future<UserWalletResponse> getUserWallet() async {
    return _client.getUserWallet();
  }

  Future<List<ServicesResponse>> getServices() async {
    return _client.getServices();
  }

  Future<SearchPlaceResponse> searchPlace(
      {String key, language, region, query}) async {
    return _googleClient.searchPlace(key, language, region, query);
  }

  Future<List<UserCardResponse>> getCard() async {
    return _client.getCard();
  }

  Future<dynamic> addMoney(UserAddMoneyRequest userAddMoneyRequest) async {
    return _client.addMoney(userAddMoneyRequest);
  }

  Future<OfferResponse> getOffer() async {
    return _client.getOffer();
  }

  Future<RequestCheckResponse> getRequestCheck() async {
    return _client.getRequestCheck();
  }

  Future<List<ShowProviderResponse>> getShowProvider(
      {double latitude, double longitude}) async {
    return _client.getShowProvider(latitude, longitude);
  }

  Future<SendRequestResponse> sendRequest(SendRequest sendRequest) async {
    return _client.sendRequest(sendRequest: sendRequest);
  }

  Future<BaseResponse> addCard(String stripeToken) async {
    return _client.addCard(stripeToken);
  }

  Future<BaseResponse> deleteCard(String cardId, String method) async {
    return _client.deleteCard(cardId, method);
  }

  Future<RateProviderResponse> rateProvider(
      RateProviderRequest rateProviderRequest) async {
    return _client.rateProvider(
        rating: rateProviderRequest.rating,
        comment: rateProviderRequest.comment,
        requestId: rateProviderRequest.requestId);
  }

  Future<void> makePhoneCall(String phone) async {
    String tel = 'tel:$phone';
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }

  Future<CancelResponse> cancelBooking(
      CancelBookingRequest cancelRequest) async {
    return _client.cancelBooking(
        cancelReason: cancelRequest.cancelReason,
        requestId: cancelRequest.requestId);
  }

  Future<List<PastTripDetail>> getPastTripDetail(int request_id) async {
    return _client.pastTripDetail(request_id);
  }

  Future<List<UpcomingTripDetail>> getUpcomingTripDetail(int request_id) async {
    return _client.upcomingTripDetail(request_id);
  }

  Future<List<DisputeListResponse>> getDisputeList(String disputeType) async {
    return _client.getDisputeList(disputeType);
  }

  Future<UpdateLanguageResponse> updateLanguage({String langCode}) {
    return _client.updateLanguage(langCode: langCode);
  }

  Future<DisputeResponse> dispute(DisputeRequest request) {
    return _client.dispute(request);
  }

  Future<BaseResponse> reportLostItem(ReportLostItemRequest request) {
    return _client.dropItem(request);
  }

  Future<SearchPlaceByLatLngResponse> searchPlaceByLatLng(
      SearchPlaceRequest searchPlaceRequest) {
    return _googleClient.searchPlaceByLatLng(request: searchPlaceRequest);
  }

  @override
  Future<List<NotificationResponse>> getListNotification() {
    return _client.getListNotification();
  }

  Future<void> postChatItem({String sender, String userId, String message}) {
    return _client.postChatItem(
        sender: sender, userId: userId, message: message);
  }

  @override
  Future<List<CancelReasonResponse>> getListCancelReason() {
    return _client.cancelReasons();
  }
}
