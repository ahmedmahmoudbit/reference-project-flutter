import 'package:get_it/get_it.dart';
import 'package:reference_project_flutter/core/cubit/cubit.dart';
import 'package:reference_project_flutter/core/network/local/cache_helper.dart';
import 'package:reference_project_flutter/core/network/remote/dio_helper.dart';
import 'package:reference_project_flutter/core/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => MainBloc(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
