// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.paymentMode,
    this.userType,
    this.email,
    this.gender,
    this.countryCode,
    this.mobile,
    this.picture,
    this.deviceToken,
    this.deviceId,
    this.deviceType,
    this.loginBy,
    this.socialUniqueId,
    this.latitude,
    this.longitude,
    this.stripeCustId,
    this.walletBalance,
    this.rating,
    this.otp,
    this.language,
    this.qrcodeUrl,
    this.referralUniqueId,
    this.referalCount,
    this.trialEndsAt,
    this.updatedAt,
    this.accessToken,
    this.currency,
    this.sos,
    this.appContact,
    this.measurement,
  });

  int id;
  String firstName;
  String lastName;
  String paymentMode;
  String userType;
  String email;
  String gender;
  String countryCode;
  String mobile;
  dynamic picture;
  String deviceToken;
  String deviceId;
  String deviceType;
  String loginBy;
  dynamic socialUniqueId;
  dynamic latitude;
  dynamic longitude;
  dynamic stripeCustId;
  int walletBalance;
  String rating;
  int otp;
  dynamic language;
  String qrcodeUrl;
  String referralUniqueId;
  int referalCount;
  dynamic trialEndsAt;
  DateTime updatedAt;
  String accessToken;
  String currency;
  String sos;
  String appContact;
  String measurement;

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
    userType: json["user_type"] == null ? null : json["user_type"],
    email: json["email"] == null ? null : json["email"],
    gender: json["gender"] == null ? null : json["gender"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    picture: json["picture"],
    deviceToken: json["device_token"] == null ? null : json["device_token"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    loginBy: json["login_by"] == null ? null : json["login_by"],
    socialUniqueId: json["social_unique_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    stripeCustId: json["stripe_cust_id"],
    walletBalance: json["wallet_balance"] == null ? null : json["wallet_balance"],
    rating: json["rating"] == null ? null : json["rating"],
    otp: json["otp"] == null ? null : json["otp"],
    language: json["language"],
    qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
    referralUniqueId: json["referral_unique_id"] == null ? null : json["referral_unique_id"],
    referalCount: json["referal_count"] == null ? null : json["referal_count"],
    trialEndsAt: json["trial_ends_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    accessToken: json["access_token"] == null ? null : json["access_token"],
    currency: json["currency"] == null ? null : json["currency"],
    sos: json["sos"] == null ? null : json["sos"],
    appContact: json["app_contact"] == null ? null : json["app_contact"],
    measurement: json["measurement"] == null ? null : json["measurement"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "payment_mode": paymentMode == null ? null : paymentMode,
    "user_type": userType == null ? null : userType,
    "email": email == null ? null : email,
    "gender": gender == null ? null : gender,
    "country_code": countryCode == null ? null : countryCode,
    "mobile": mobile == null ? null : mobile,
    "picture": picture,
    "device_token": deviceToken == null ? null : deviceToken,
    "device_id": deviceId == null ? null : deviceId,
    "device_type": deviceType == null ? null : deviceType,
    "login_by": loginBy == null ? null : loginBy,
    "social_unique_id": socialUniqueId,
    "latitude": latitude,
    "longitude": longitude,
    "stripe_cust_id": stripeCustId,
    "wallet_balance": walletBalance == null ? null : walletBalance,
    "rating": rating == null ? null : rating,
    "otp": otp == null ? null : otp,
    "language": language,
    "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
    "referral_unique_id": referralUniqueId == null ? null : referralUniqueId,
    "referal_count": referalCount == null ? null : referalCount,
    "trial_ends_at": trialEndsAt,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "access_token": accessToken == null ? null : accessToken,
    "currency": currency == null ? null : currency,
    "sos": sos == null ? null : sos,
    "app_contact": appContact == null ? null : appContact,
    "measurement": measurement == null ? null : measurement,
  };
}
