import 'package:dio/dio.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/model/search_place_by_latlng_response.dart';
import 'package:flutter_map_booking/model/search_place_request.dart';
import 'package:flutter_map_booking/model/search_place_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_client.g.dart';

@RestApi(baseUrl: GOOGLE_BASE_URL)
abstract class GoogleClient {
  factory GoogleClient(Dio dio) = _GoogleClient;

  @GET("place/textsearch/json")
  Future<SearchPlaceResponse> searchPlace(
      @Query("key") String key,
      @Query("language") String language,
      @Query("region") String region,
      @Query("query") String query);

  @GET("geocode/json")
  Future<SearchPlaceByLatLngResponse> searchPlaceByLatLng(
      {@Queries() SearchPlaceRequest request});
}
