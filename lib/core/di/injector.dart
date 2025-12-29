import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/network/dio_factory.dart';
import 'package:flutter_app_template/core/routes/router.dart';
import 'package:flutter_app_template/core/services/auth_service.dart';
import 'package:flutter_app_template/core/utils/environment.dart';
import 'package:flutter_app_template/core/utils/secure_storage_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //! Core
  await dotenv.load(fileName: ".env");
  final env = Environment.fromDotEnv();
  injector.registerSingleton<Environment>(env);

  const FlutterSecureStorage storage = FlutterSecureStorage();
  injector.registerLazySingleton(() => SecureStorageHelper(storage: storage));

  injector.registerLazySingleton(() => router);

  injector.registerLazySingleton<Dio>(() => DioFactory(env.baseUrl).create());

  //! Service
  injector.registerLazySingleton<AuthService>(
    () => AuthService(
      dio: injector<Dio>(),
      tokenStorage: injector<SecureStorageHelper>(),
    ),
  );
}
