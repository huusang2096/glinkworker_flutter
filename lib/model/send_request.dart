// To parse this JSON data, do
//
//     final sendRequest = sendRequestFromJson(jsonString);

import 'dart:convert';

class SendRequest {
  SendRequest({
    this.paymentMode,
    this.serviceType,
    this.scheduleTime,
    this.sLatitude,
    this.scheduleDate,
    this.sAddress,
    this.sLongitude,
    this.promocodeId,
    this.useWallet,
  });

  String paymentMode;
  int serviceType;
  String scheduleTime;
  double sLatitude;
  String scheduleDate;
  String sAddress;
  double sLongitude;
  int promocodeId;
  int useWallet;

  @override
  String toString() {
    return 'SendRequest{paymentMode: $paymentMode, serviceType: $serviceType, scheduleTime: $scheduleTime, sLatitude: $sLatitude, scheduleDate: $scheduleDate, sAddress: $sAddress, sLongitude: $sLongitude, promocodeId: $promocodeId, useWallet: $useWallet}';
  }

  factory SendRequest.fromRawJson(String str) =>
      SendRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendRequest.fromJson(Map<String, dynamic> json) => SendRequest(
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        serviceType: json["service_type"] == null ? null : json["service_type"],
        scheduleTime:
            json["schedule_time"] == null ? null : json["schedule_time"],
        sLatitude:
            json["s_latitude"] == null ? null : json["s_latitude"].toDouble(),
        scheduleDate:
            json["schedule_date"] == null ? null : json["schedule_date"],
        sAddress: json["s_address"] == null ? null : json["s_address"],
        sLongitude:
            json["s_longitude"] == null ? null : json["s_longitude"].toDouble(),
        promocodeId: json["promocode_id"] == null ? null : json["promocode_id"],
        useWallet: json["use_wallet"] == null ? null : json["use_wallet"],
      );

  Map<String, dynamic> toJson() => {
        "payment_mode": paymentMode == null ? null : paymentMode,
        "service_type": serviceType == null ? null : serviceType,
        "schedule_time": scheduleTime == null ? null : scheduleTime,
        "s_latitude": sLatitude == null ? null : sLatitude,
        "schedule_date": scheduleDate == null ? null : scheduleDate,
        "s_address": sAddress == null ? null : sAddress,
        "s_longitude": sLongitude == null ? null : sLongitude,
        "promocode_id": promocodeId == null ? null : promocodeId,
        "use_wallet": useWallet == null ? null : useWallet,
      };
}
