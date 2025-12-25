import 'package:flutter_app_template/core/routes/router.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerLazySingleton(() => router);
}
