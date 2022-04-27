import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/core/cubit/state.dart';
import 'package:reference_project_flutter/core/di/injection.dart';
import 'package:reference_project_flutter/core/network/local/cache_helper.dart';
import 'package:reference_project_flutter/core/network/repository.dart';

class MainBloc extends Cubit<MainState> {
  final Repository _repository;

  MainBloc({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static MainBloc get(context) => BlocProvider.of(context);


  /// variables bool
  bool isRtl = false;
  bool isDark = false;

  /// variables int
  int? currentPage;

  /// dark colors
  String scaffoldBackground = '11202a';
  String mainColorDark = 'ffffff';
  String mainColorVariantDark = '8a8a89';

  /// dark colors
  String secondaryDark = 'ffffff';
  String secondaryVariantDark = '8a8a89';

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  void setThemes({
    required bool dark,
  }) {
    isDark = dark;
    sl<CacheHelper>().put('isDark', isDark);
    changeTheme();
    emit(ThemeLoaded());
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  void changeTheme() {
    lightTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(mainColor),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Color(0xffd4cab2),
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: HexColor(mainColor),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(mainColor),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: isDark ? HexColor(textColorD) : HexColor(TextMainColor),
          height: 1.3,
        ),
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: isDark ? HexColor(textColorD) : HexColor(TextMainColor),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
          color: isDark ? HexColor(secondaryDark) : HexColor(brownColor),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: isDark ? HexColor(textColorD) : HexColor(TextMainColor),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: isDark ? HexColor(textColorD) : HexColor(TextMainColor),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: HexColor(appBarColor),
          height: 1.4,
        ),
        button: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
    darkTheme = ThemeData(
      primaryColor: HexColor(mainColorD),
      primaryColorLight: HexColor(secondaryColorD),
      primaryColorDark: HexColor(textColorD),
      scaffoldBackgroundColor: HexColor(mainColorD),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Color(0x00060a0c),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: HexColor(grey),
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: HexColor(surface),
          height: 1.3,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        button: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  void changeMode({required bool value}) {
    isDark = value;
    sl<CacheHelper>().put('isDark', isDark);
    emit(ChangeModeState());
  }



}
