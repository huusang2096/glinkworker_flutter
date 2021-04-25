// To parse this JSON data, do
//
//     final disputeList = disputeListFromJson(jsonString);

import 'dart:convert';

class DisputeRequest {
  DisputeRequest({
    this.disputeType,
    this.disputeName,
    this.userId,
    this.providerId,
    this.requestId,
    this.comments,
  });

  String disputeType;
  String disputeName;
  int userId;
  int providerId;
  int requestId;
  String comments;

  factory DisputeRequest.fromRawJson(String str) =>
      DisputeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisputeRequest.fromJson(Map<String, dynamic> json) => DisputeRequest(
        disputeType: json["dispute_type"] == null ? null : json["dispute_type"],
        disputeName: json["dispute_name"] == null ? null : json["dispute_name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        comments: json["comments"] == null ? null : json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "dispute_type": disputeType == null ? null : disputeType,
        "dispute_name": disputeName == null ? null : disputeName,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId == null ? null : providerId,
        "request_id": requestId == null ? null : requestId,
        "comments": comments == null ? null : comments,
      };
}
