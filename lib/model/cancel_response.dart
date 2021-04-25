// To parse this JSON data, do
//
//     final cancelResponse = cancelResponseFromJson(jsonString);

import 'dart:convert';

class CancelResponse {
  CancelResponse({
    this.status,
    this.errorCode,
    this.message,
  });

  bool status;
  String errorCode;
  String message;

  factory CancelResponse.fromRawJson(String str) => CancelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelResponse.fromJson(Map<String, dynamic> json) => CancelResponse(
    status: json["status"] == null ? null : json["status"],
    errorCode: json["error_code"] == null ? null : json["error_code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "error_code": errorCode == null ? null : errorCode,
    "message": message == null ? null : message,
  };
}
