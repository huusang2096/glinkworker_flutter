// To parse this JSON data, do
//
//     final UpdateProfileRequest = UpdateProfileRequestFromJson(jsonString);

import 'dart:io';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.countryCode,
    this.mobile,
    this.lastName,
    this.firstName,
    this.email,
    this.picture,
  });

  String countryCode;
  String mobile;
  String lastName;
  String firstName;
  String email;
  File picture;
}
