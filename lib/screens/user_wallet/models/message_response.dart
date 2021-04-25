// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

class MessageResponse {
  MessageResponse({
    this.message,
  });

  String message;

  factory MessageResponse.fromRawJson(String str) => MessageResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
