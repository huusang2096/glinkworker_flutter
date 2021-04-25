import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/model/base_response.dart';
import 'package:flutter_map_booking/model/cancel_reason_response.dart';
import 'package:flutter_map_booking/model/cancel_response.dart';
import 'package:flutter_map_booking/model/dispute_response.dart';
import 'package:flutter_map_booking/model/forgot_password_request.dart';
import 'package:flutter_map_booking/model/login_request.dart';
import 'package:flutter_map_booking/model/login_response.dart';
import 'package:flutter_map_booking/model/notification_response.dart';
import 'package:flutter_map_booking/model/offer_response.dart';
import 'package:flutter_map_booking/model/profile_response.dart';
import 'package:flutter_map_booking/model/rate_provider_response.dart';
import 'package:flutter_map_booking/model/register_request.dart';
import 'package:flutter_map_booking/model/register_response.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/model/send_request.dart';
import 'package:flutter_map_booking/model/send_request_response.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/model/show_provider_response.dart';
import 'package:flutter_map_booking/model/update_language_response.dart';
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
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @FormUrlEncoded()
  @POST("api/user/oauth/token")
  Future<LoginResponse> login({@Body() LoginRequest request});

  @POST("api/user/logout")
  @FormUrlEncoded()
  Future<void> logout({
    @Field("id") String userId,
  });

  @GET("api/user/details")
  Future<ProfileResponse> getProfile();

  @POST("api/user/update/profile")
  @MultiPart()
  Future<ProfileResponse> updateProfile({
    @Part() String mobile,
    @Part(name: 'country_code') String countryCode,
    @Part(name: 'last_name') String lastName,
    @Part(name: 'first_name') String firstName,
    @Part() String email,
    @Part() File picture,
  });

  @GET("api/user/wallet/passbook")
  Future<UserWalletResponse> getUserWallet();

  @GET("api/user/trips")
  Future<List<UserRequestHistoryResponse>> getUserRequestPastHistory();

  @GET("api/user/upcoming/trips")
  Future<List<UserRequestUpcomingHistoryResponse>>
      getUserRequestUpcomingHistory();

  @POST("api/user/signup")
  @FormUrlEncoded()
  Future<RegisterResponse> loginOrRegister(
      @Body() RegisterRequest registerRequest);

  @GET("/api/user/services")
  Future<List<ServicesResponse>> getServices();

  @GET("/api/user/card")
  Future<List<UserCardResponse>> getCard();

  @POST("/api/user/card")
  @FormUrlEncoded()
  Future<BaseResponse> addCard(@Field("stripe_token") String stripeToken);

  @POST("/api/user/add/money")
  @FormUrlEncoded()
  Future<dynamic> addMoney(@Body() UserAddMoneyRequest userAddMoneyRequest);

  @GET("api/user/promocodes_list")
  Future<OfferResponse> getOffer();

  @GET("api/user/request/check")
  Future<RequestCheckResponse> getRequestCheck();

  @GET("api/user/show/providers")
  Future<List<ShowProviderResponse>> getShowProvider(
      @Query("latitude") double latitude, @Query("longitude") double longitude);

  @POST("api/user/send/request")
  @FormUrlEncoded()
  Future<SendRequestResponse> sendRequest({@Body() SendRequest sendRequest});

  @POST("api/user/card/destroy")
  @FormUrlEncoded()
  Future<BaseResponse> deleteCard(
      @Field("card_id") String cardId, @Field("_method") String method);

  @POST("api/user/reset-pass-with-otp-token")
  @FormUrlEncoded()
  Future<void> resetPassword(
      @Body() ForgotPasswordRequest forgotPasswordRequest);

  @GET("api/user/notifications/provider")
  Future<List<NotificationResponse>> getListNotification();

  @POST("api/user/rate/provider")
  @FormUrlEncoded()
  Future<RateProviderResponse> rateProvider(
      {@Field("rating") int rating,
      @Field("comment") String comment,
      @Field("request_id") int requestId});

  @POST("api/user/cancel/request")
  @FormUrlEncoded()
  Future<CancelResponse> cancelBooking({
    @Field("request_id") int requestId,
    @Field("cancel_reason") String cancelReason,
  });

  @GET("api/user/trip/details")
  Future<List<PastTripDetail>> pastTripDetail(
      @Query("request_id") int requestId);

  @GET("api/user/upcoming/trip/details")
  Future<List<UpcomingTripDetail>> upcomingTripDetail(
      @Query("request_id") int requestId);

  @POST("api/user/dispute-list")
  @FormUrlEncoded()
  Future<List<DisputeListResponse>> getDisputeList(
      @Field("dispute_type") String disputeType);

  @POST("api/user/dispute")
  @FormUrlEncoded()
  Future<DisputeResponse> dispute(@Body() DisputeRequest request);

  @POST("api/user/update/language")
  @FormUrlEncoded()
  Future<UpdateLanguageResponse> updateLanguage(
      {@Field("language") String langCode});

  @POST("api/user/drop-item")
  @FormUrlEncoded()
  Future<BaseResponse> dropItem(@Body() ReportLostItemRequest request);

  @POST("api/user/chat")
  @FormUrlEncoded()
  Future<void> postChatItem(
      {@Field('sender') String sender,
      @Field('user_id') String userId,
      @Field('message') String message});

  @GET("api/user/reasons")
  Future<List<CancelReasonResponse>> cancelReasons();
}
