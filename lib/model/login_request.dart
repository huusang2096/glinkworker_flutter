// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

class LoginRequest {
  LoginRequest({
    this.password,
    this.deviceId,
    this.deviceToken,
    this.deviceType,
    this.clientSecret,
    this.clientId,
    this.grantType,
    this.username,
    this.mobile,
    this.countryCode,
  });

  String password;
  String deviceId;
  String deviceToken;
  String deviceType;
  String clientSecret;
  String clientId;
  String grantType;
  String username;
  String mobile;
  String countryCode;

  factory LoginRequest.fromRawJson(String str) =>
      LoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        password: json["password"] == null ? null : json["password"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        deviceType: json["device_type"] == null ? null : json["device_type"],
        clientSecret:
            json["client_secret"] == null ? null : json["client_secret"],
        clientId: json["client_id"] == null ? null : json["client_id"],
        grantType: json["grant_type"] == null ? null : json["grant_type"],
        username: json["username"] == null ? null : json["username"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "password": password == null ? null : password,
        "device_id": deviceId == null ? null : deviceId,
        "device_token": deviceToken == null ? null : deviceToken,
        "device_type": deviceType == null ? null : deviceType,
        "client_secret": clientSecret == null ? null : clientSecret,
        "client_id": clientId == null ? null : clientId,
        "grant_type": grantType == null ? null : grantType,
        "username": username == null ? null : username,
        "mobile": mobile == null ? null : mobile,
        "country_code": countryCode == null ? null : countryCode,
      };
}
