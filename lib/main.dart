import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reference_project_flutter/core/cubit/cubit.dart';
import 'package:reference_project_flutter/core/di/injection.dart' as di;
import 'package:reference_project_flutter/core/di/injection.dart';
import 'package:reference_project_flutter/core/network/local/cache.dart';
import 'package:reference_project_flutter/core/network/local/cache_helper.dart';
import 'package:reference_project_flutter/features/home.dart';
import 'package:reference_project_flutter/features/todo/data/create_db.dart';
import 'core/cubit/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CacheHelperw.init();
  await DBHelper.initDb();

  bool isDark = false;
  await sl<CacheHelper>().get('isDark').then((value) {
    debugPrint('dark mode ------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MainBloc>()
        ..setThemes(change: isDark)
        ..getTask(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode:
                MainBloc.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: MainBloc.get(context).lightTheme,
            darkTheme: MainBloc.get(context).darkTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

// run maps
  // return BlocProvider(
    // create: (BuildContext context) =>
      // MapsCubit(MapsRepository(PlacesWebservices())),
        // child: BlocBuilder<MapsCubit, MapsState>(
          // builder: (context, state) {
            // return MaterialApp(
              // debugShowCheckedModeBanner: false,
                // title: 'Flutter Demo',
              // theme: buildThemeData(),
            // // home: MainMaps(instance()),
          // home: const OrderTrackingPage(),
        // );
      // },
    // ),
  // );
