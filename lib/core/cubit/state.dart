import 'package:meta/meta.dart';

@immutable
abstract class MainState {}

class Empty extends MainState {}

class Loading extends MainState {}

class Error extends MainState {
  final String error;
  Error(this.error);
}

class ChangeModeState extends MainState {}

class ThemeLoaded extends MainState {}

