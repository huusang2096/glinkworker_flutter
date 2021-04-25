// To parse this JSON data, do
//
//     final userAddMoneyResponse = userAddMoneyResponseFromJson(jsonString);

import 'dart:convert';

class UserAddMoneyResponse {
  UserAddMoneyResponse({
    this.success,
    this.message,
    this.balance,
  });

  String success;
  String message;
  double balance;

  factory UserAddMoneyResponse.fromRawJson(String str) => UserAddMoneyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAddMoneyResponse.fromJson(Map<String, dynamic> json) => UserAddMoneyResponse(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "balance": balance == null ? null : balance,
  };
}
