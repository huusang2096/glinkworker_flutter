// To parse this JSON data, do
//
//     final reportItemRequest = reportItemRequestFromJson(jsonString);

import 'dart:convert';

class ReportLostItemRequest {
  ReportLostItemRequest({
    this.requestId,
    this.userId,
    this.lostItemName,
  });

  int requestId;
  int userId;
  String lostItemName;

  factory ReportLostItemRequest.fromRawJson(String str) =>
      ReportLostItemRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportLostItemRequest.fromJson(Map<String, dynamic> json) =>
      ReportLostItemRequest(
        requestId: json["request_id"] == null ? null : json["request_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        lostItemName:
            json["lost_item_name"] == null ? null : json["lost_item_name"],
      );

  Map<String, dynamic> toJson() => {
        "request_id": requestId == null ? null : requestId,
        "user_id": userId == null ? null : userId,
        "lost_item_name": lostItemName == null ? null : lostItemName,
      };
}
