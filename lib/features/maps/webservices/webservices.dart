import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// webSite
// https://developers.google.com/maps/documentation/places/web-service/details

const String googleAPIKey = 'AIzaSyCyoCFUgMy9nBPsdZfzd9fPwoQAq7G3nGs';
// const String googleAPIKey = 'AIzaSyACbkNR08VnxiIfnekxOfMV6TLuCcNoox8';
// const String googleAPIKey = 'AIzaSyAbCeJmWjprZkI5wM0PBMvLRqG942TxL1M';
// const String googleAPIKey = 'AIzaSyC1r96dCzZ3dYsuZymAmMJgSlhGSeOmiz8';

const suggestionsBaseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
const placeLocationBaseUrl = 'https://maps.googleapis.com/maps/api/place/details/json';
const directionsBaseUrl = 'https://maps.googleapis.com/maps/api/directions/json';

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions(String place,
      String sessionToken) async {
    try {
      Response response = await dio.get(
        suggestionsBaseUrl,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
      print('fetchSuggestions: ${response.data['predictions']}');
      print(response.statusCode);
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }

  // origin equals current location
  // destination equals searched for location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );
      print("Omar I'm testing directions");
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}