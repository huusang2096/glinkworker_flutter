import 'dart:convert';

class SendRequestResponse {
  SendRequestResponse({
    this.error,
    this.message,
    this.requestId,
    this.currentProvider,
  });

  String error;
  String message;
  int requestId;
  int currentProvider;

  factory SendRequestResponse.fromRawJson(String str) => SendRequestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendRequestResponse.fromJson(Map<String, dynamic> json) => SendRequestResponse(
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    requestId: json["request_id"] == null ? null : json["request_id"],
    currentProvider: json["current_provider"] == null ? null : json["current_provider"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "request_id": requestId == null ? null : requestId,
    "current_provider": currentProvider == null ? null : currentProvider,
  };
}
