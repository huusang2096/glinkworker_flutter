// To parse this JSON data, do
//
//     final offerResponse = offerResponseFromJson(jsonString);

import 'dart:convert';

class OfferResponse {
  OfferResponse({
    this.promoList,
  });

  List<PromoList> promoList;

  factory OfferResponse.fromRawJson(String str) => OfferResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferResponse.fromJson(Map<String, dynamic> json) => OfferResponse(
    promoList: json["promo_list"] == null ? null : List<PromoList>.from(json["promo_list"].map((x) => PromoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "promo_list": promoList == null ? null : List<dynamic>.from(promoList.map((x) => x.toJson())),
  };
}

class PromoList {
  PromoList({
    this.id,
    this.promoCode,
    this.percentage,
    this.maxAmount,
    this.promoDescription,
    this.expiration,
    this.status,
    this.deletedAt,
    this.createdAt,
  });

  int id;
  String promoCode;
  int percentage;
  int maxAmount;
  String promoDescription;
  DateTime expiration;
  String status;
  dynamic deletedAt;
  DateTime createdAt;

  factory PromoList.fromRawJson(String str) => PromoList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PromoList.fromJson(Map<String, dynamic> json) => PromoList(
    id: json["id"] == null ? null : json["id"],
    promoCode: json["promo_code"] == null ? null : json["promo_code"],
    percentage: json["percentage"] == null ? null : json["percentage"],
    maxAmount: json["max_amount"] == null ? null : json["max_amount"],
    promoDescription: json["promo_description"] == null ? null : json["promo_description"],
    expiration: json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
    status: json["status"] == null ? null : json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "promo_code": promoCode == null ? null : promoCode,
    "percentage": percentage == null ? null : percentage,
    "max_amount": maxAmount == null ? null : maxAmount,
    "promo_description": promoDescription == null ? null : promoDescription,
    "expiration": expiration == null ? null : expiration.toIso8601String(),
    "status": status == null ? null : status,
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}
