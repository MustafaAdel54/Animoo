import 'package:animoo/core/database/api/dio_services.dart';
import 'package:animoo/core/service/get_it_service.dart';
import 'package:animoo/core/service/token_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

extension GetItExtension on GetIt {
  DioServices get dioService => getIt<DioServices>();

  Dio get dio => getIt<Dio>();

  TokenStorageService get tokenStorageService => getIt<TokenStorageService>();
}
