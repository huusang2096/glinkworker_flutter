// To parse this JSON data, do
//
//     final updateLanguageResponse = updateLanguageResponseFromJson(jsonString);

import 'dart:convert';

class UpdateLanguageResponse {
  UpdateLanguageResponse({
    this.message,
    this.language,
  });

  String message;
  String language;

  factory UpdateLanguageResponse.fromRawJson(String str) =>
      UpdateLanguageResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateLanguageResponse.fromJson(Map<String, dynamic> json) =>
      UpdateLanguageResponse(
        message: json["message"] == null ? null : json["message"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "language": language == null ? null : language,
      };
}
