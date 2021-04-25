// To parse this JSON data, do
//
//     final searchPlaceRequest = searchPlaceRequestFromJson(jsonString);

import 'dart:convert';

class SearchPlaceRequest {
  SearchPlaceRequest({
    this.key,
    this.language,
    this.region,
    this.query,
    this.latLng,
  });

  String key;
  String language;
  String region;
  String query;
  String latLng;

  factory SearchPlaceRequest.fromRawJson(String str) =>
      SearchPlaceRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchPlaceRequest.fromJson(Map<String, dynamic> json) =>
      SearchPlaceRequest(
        key: json["key"] == null ? null : json["key"],
        language: json["language"] == null ? null : json["language"],
        region: json["region"] == null ? null : json["region"],
        query: json["query"] == null ? null : json["query"],
        latLng: json["latlng"] == null ? null : json["latlng"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "language": language == null ? null : language,
        "region": region == null ? null : region,
        "query": query == null ? null : query,
        "latlng": latLng == null ? null : latLng,
      };
}
