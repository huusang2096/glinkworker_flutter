// To parse this JSON data, do
//
//     final userWalletResponse = userWalletResponseFromJson(jsonString);

import 'dart:convert';

class UserWalletResponse {
  UserWalletResponse({
    this.walletTransation,
    this.walletBalance,
  });

  List<WalletTransation> walletTransation;
  int walletBalance;

  factory UserWalletResponse.fromRawJson(String str) =>
      UserWalletResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserWalletResponse.fromJson(Map<String, dynamic> json) =>
      UserWalletResponse(
        walletTransation: json["wallet_transation"] == null
            ? null
            : List<WalletTransation>.from(json["wallet_transation"]
                .map((x) => WalletTransation.fromJson(x))),
        walletBalance:
            json["wallet_balance"] == null ? null : json["wallet_balance"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_transation": walletTransation == null
            ? null
            : List<dynamic>.from(walletTransation.map((x) => x.toJson())),
        "wallet_balance": walletBalance == null ? null : walletBalance,
      };
}

class WalletTransation {
  WalletTransation({
    this.id,
    this.userId,
    this.transactionId,
    this.transactionAlias,
    this.transactionDesc,
    this.type,
    this.amount,
    this.openBalance,
    this.closeBalance,
    this.paymentMode,
    this.createdAt,
  });

  int id;
  int userId;
  int transactionId;
  String transactionAlias;
  String transactionDesc;
  String type;
  int amount;
  int openBalance;
  int closeBalance;
  String paymentMode;
  DateTime createdAt;

  factory WalletTransation.fromRawJson(String str) =>
      WalletTransation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletTransation.fromJson(Map<String, dynamic> json) =>
      WalletTransation(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        transactionAlias: json["transaction_alias"] == null
            ? null
            : json["transaction_alias"],
        transactionDesc:
            json["transaction_desc"] == null ? null : json["transaction_desc"],
        type: json["type"] == null ? null : json["type"],
        amount: json["amount"] == null ? null : json["amount"],
        openBalance: json["open_balance"] == null ? null : json["open_balance"],
        closeBalance:
            json["close_balance"] == null ? null : json["close_balance"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "transaction_id": transactionId == null ? null : transactionId,
        "transaction_alias": transactionAlias == null ? null : transactionAlias,
        "transaction_desc": transactionDesc == null ? null : transactionDesc,
        "type": type == null ? null : type,
        "amount": amount == null ? null : amount,
        "open_balance": openBalance == null ? null : openBalance,
        "close_balance": closeBalance == null ? null : closeBalance,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
