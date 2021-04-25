
// To parse this JSON data, do
//
//     final showProviderResponse = showProviderResponseFromJson(jsonString);

import 'dart:convert';

class ShowProviderResponse {
  ShowProviderResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.countryCode,
    this.mobile,
    this.avatar,
    this.rating,
    this.status,
    this.agent,
    this.latitude,
    this.longitude,
    this.stripeAccId,
    this.stripeCustId,
    this.paypalEmail,
    this.loginBy,
    this.socialUniqueId,
    this.otp,
    this.walletBalance,
    this.referralUniqueId,
    this.qrcodeUrl,
    this.trialProEndsAt,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String countryCode;
  String mobile;
  String avatar;
  String rating;
  String status;
  int agent;
  double latitude;
  double longitude;
  dynamic stripeAccId;
  String stripeCustId;
  dynamic paypalEmail;
  String loginBy;
  dynamic socialUniqueId;
  int otp;
  int walletBalance;
  String referralUniqueId;
  String qrcodeUrl;
  dynamic trialProEndsAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Service> service;

  factory ShowProviderResponse.fromRawJson(String str) => ShowProviderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowProviderResponse.fromJson(Map<String, dynamic> json) => ShowProviderResponse(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    gender: json["gender"] == null ? null : json["gender"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    rating: json["rating"] == null ? null : json["rating"],
    status: json["status"] == null ? null : json["status"],
    agent: json["agent"] == null ? null : json["agent"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    stripeAccId: json["stripe_acc_id"],
    stripeCustId: json["stripe_cust_id"] == null ? null : json["stripe_cust_id"],
    paypalEmail: json["paypal_email"],
    loginBy: json["login_by"] == null ? null : json["login_by"],
    socialUniqueId: json["social_unique_id"],
    otp: json["otp"] == null ? null : json["otp"],
    walletBalance: json["wallet_balance"] == null ? null : json["wallet_balance"],
    referralUniqueId: json["referral_unique_id"] == null ? null : json["referral_unique_id"],
    qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
    trialProEndsAt: json["trial_pro_ends_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    service: json["service"] == null ? null : List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "gender": gender == null ? null : gender,
    "country_code": countryCode == null ? null : countryCode,
    "mobile": mobile == null ? null : mobile,
    "avatar": avatar == null ? null : avatar,
    "rating": rating == null ? null : rating,
    "status": status == null ? null : status,
    "agent": agent == null ? null : agent,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "stripe_acc_id": stripeAccId,
    "stripe_cust_id": stripeCustId == null ? null : stripeCustId,
    "paypal_email": paypalEmail,
    "login_by": loginBy == null ? null : loginBy,
    "social_unique_id": socialUniqueId,
    "otp": otp == null ? null : otp,
    "wallet_balance": walletBalance == null ? null : walletBalance,
    "referral_unique_id": referralUniqueId == null ? null : referralUniqueId,
    "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
    "trial_pro_ends_at": trialProEndsAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "service": service == null ? null : List<dynamic>.from(service.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    this.id,
    this.providerId,
    this.serviceTypeId,
    this.status,
    this.serviceNumber,
    this.serviceModel,
  });

  int id;
  int providerId;
  int serviceTypeId;
  String status;
  String serviceNumber;
  String serviceModel;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    providerId: json["provider_id"] == null ? null : json["provider_id"],
    serviceTypeId: json["service_type_id"] == null ? null : json["service_type_id"],
    status: json["status"] == null ? null : json["status"],
    serviceNumber: json["service_number"] == null ? null : json["service_number"],
    serviceModel: json["service_model"] == null ? null : json["service_model"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "provider_id": providerId == null ? null : providerId,
    "service_type_id": serviceTypeId == null ? null : serviceTypeId,
    "status": status == null ? null : status,
    "service_number": serviceNumber == null ? null : serviceNumber,
    "service_model": serviceModel == null ? null : serviceModel,
  };
}
