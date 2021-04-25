// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

class DisputeResponse {
  DisputeResponse({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory DisputeResponse.fromRawJson(String str) =>
      DisputeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisputeResponse.fromJson(Map<String, dynamic> json) =>
      DisputeResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
