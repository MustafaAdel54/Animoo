import 'package:animoo/core/database/api/dio_services.dart';
import 'package:animoo/core/service/token_storage_service.dart';
import 'package:animoo/core/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioServices>(() => DioServices(getIt.dio));
  getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService());
}
