// To parse this JSON data, do
//
//     final locationData = locationDataFromJson(jsonString);

import 'dart:convert';

class LocationData {
  double bearing;
  double lat;
  double lng;

  LocationData({
    this.bearing,
    this.lat,
    this.lng,
  });

  factory LocationData.fromRawJson(String str) =>
      LocationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        bearing: json["bearing"] == null ? null : json["bearing"].toDouble(),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "bearing": bearing == null ? null : bearing,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
