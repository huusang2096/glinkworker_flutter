// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

class RegisterRequest {
  String countryCode;
  String password;
  String passwordConfirmation;
  String deviceId;
  String deviceToken;
  String mobile;
  String lastName;
  String firstName;
  String deviceType;
  String loginBy;
  String email;
  String verifyToken;

  RegisterRequest(
      {this.countryCode,
      this.password,
      this.passwordConfirmation,
      this.deviceId,
      this.deviceToken,
      this.mobile,
      this.lastName,
      this.firstName,
      this.deviceType,
      this.loginBy,
      this.email,
      this.verifyToken});

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
          countryCode:
              json["country_code"] == null ? null : json["country_code"],
          password: json["password"] == null ? null : json["password"],
          passwordConfirmation: json["password_confirmation"] == null
              ? null
              : json["password_confirmation"],
          deviceId: json["device_id"] == null ? null : json["device_id"],
          deviceToken:
              json["device_token"] == null ? null : json["device_token"],
          mobile: json["mobile"] == null ? null : json["mobile"],
          lastName: json["last_name"] == null ? null : json["last_name"],
          firstName: json["first_name"] == null ? null : json["first_name"],
          deviceType: json["device_type"] == null ? null : json["device_type"],
          loginBy: json["login_by"] == null ? null : json["login_by"],
          email: json["email"] == null ? null : json["email"],
          verifyToken:
              json["verify_token"] == null ? null : json["verify_token"]);

  Map<String, dynamic> toJson() => {
        "country_code": countryCode == null ? null : countryCode,
        "password": password == null ? null : password,
        "password_confirmation":
            passwordConfirmation == null ? null : passwordConfirmation,
        "device_id": deviceId == null ? null : deviceId,
        "device_token": deviceToken == null ? null : deviceToken,
        "mobile": mobile == null ? null : mobile,
        "last_name": lastName == null ? null : lastName,
        "first_name": firstName == null ? null : firstName,
        "device_type": deviceType == null ? null : deviceType,
        "login_by": loginBy == null ? null : loginBy,
        "email": email == null ? null : email,
        "verify_token": verifyToken == null ? null : verifyToken
      };
}
