
import 'package:reference_project_flutter/core/network/local/cache_helper.dart';

import 'remote/dio_helper.dart';

abstract class Repository {

}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });


}