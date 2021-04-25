import 'dart:convert';

class RateProviderResponse {
  RateProviderResponse({
    this.message,
  });

  String message;

  factory RateProviderResponse.fromRawJson(String str) => RateProviderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RateProviderResponse.fromJson(Map<String, dynamic> json) => RateProviderResponse(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
