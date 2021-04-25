// To parse this JSON data, do
//
//     final userAddMoneyRequest = userAddMoneyRequestFromJson(jsonString);

import 'dart:convert';

class UserAddMoneyRequest {
  UserAddMoneyRequest({
    this.cardId,
    this.amount,
    this.paymentMode,
    this.userType,
  });

  String cardId;
  int amount;
  String paymentMode;
  String userType;

  factory UserAddMoneyRequest.fromRawJson(String str) => UserAddMoneyRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAddMoneyRequest.fromJson(Map<String, dynamic> json) => UserAddMoneyRequest(
    cardId: json["card_id"] == null ? null : json["card_id"],
    amount: json["amount"] == null ? null : json["amount"],
    paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
    userType: json["user_type"] == null ? null : json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "card_id": cardId == null ? null : cardId,
    "amount": amount == null ? null : amount,
    "payment_mode": paymentMode == null ? null : paymentMode,
    "user_type": userType == null ? null : userType,
  };
}
