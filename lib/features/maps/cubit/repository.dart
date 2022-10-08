import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reference_project_flutter/features/maps/webservices/webservices.dart';
import 'package:reference_project_flutter/features/maps/models/Place_suggestion.dart';
import 'package:reference_project_flutter/features/maps/models/place.dart';
import 'package:reference_project_flutter/features/maps/models/place_directions.dart';

class MapsRepository {
  final PlacesWebservices placesWebservices;
  MapsRepository(this.placesWebservices);

  // الحصول على جميع المدن بناء على المدخلات
  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
    await placesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  // الحصول على معلومات واحدثيات الموقع
  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
    await placesWebservices.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }

  // حساب المسافه بين موقعين
  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
    await placesWebservices.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }


}