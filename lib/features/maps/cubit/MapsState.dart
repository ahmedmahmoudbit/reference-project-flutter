import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/maps/models/Place_suggestion.dart';
import 'package:reference_project_flutter/features/maps/models/place.dart';
import 'package:reference_project_flutter/features/maps/models/place_directions.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  final List<PlaceSuggestion> places;
  PlacesLoaded(this.places);
}

class PlaceLocationLoaded extends MapsState {
  final Place place;
  PlaceLocationLoaded(this.place);
}


class DirectionsLoaded extends MapsState {
  final PlaceDirections placeDirections;
  DirectionsLoaded(this.placeDirections);
}