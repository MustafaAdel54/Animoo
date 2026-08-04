import 'package:animoo/core/database/api/api_consts.dart';
import 'package:animoo/core/database/api/api_consumer.dart';
import 'package:animoo/core/error/server_exception.dart';
import 'package:animoo/core/print_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioServices implements ApiConsumer {
  final Dio dio;

  DioServices(this.dio) {
    _initDio();
  }

  void _initDio() {
    dio.options.baseUrl = ApiConsts.baseUrl;
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        request: true,
      ),
    ]);
  }

  @override
  Future<dynamic> delete({required String path}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response res = await dio.get(
        path,
        data: body,
        options: Options(headers: header),
        queryParameters: queryParameter,
      );
      var statusCode = res.statusCode;
      if (statusCode! >= 200 && statusCode < 300) {
        //sucess
        return res.data;
      } else {
        //failure
        throw ServerException(message: 'message', data: res.data);
      }
    } catch (e) {
      await _handleException(e);
    }
  }

  @override
  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response res = await dio.patch(
        path,
        data: body,
        options: Options(headers: header),
        queryParameters: queryParameter,
      );
      var statusCode = res.statusCode;
      if (statusCode! >= 200 && statusCode < 300) {
        //sucess
        return res.data;
      } else {
        //failure
        throw ServerException(message: 'message', data: res.data);
      }
    } catch (e) {
      await _handleException(e);
    }
  }

  @override
  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response res = await dio.put(
        path,
        data: body,
        options: Options(headers: header),
        queryParameters: queryParameter,
      );
      var statusCode = res.statusCode;
      if (statusCode! >= 200 && statusCode < 300) {
        //sucess
        return res.data;
      } else {
        //failure
        throw ServerException(message: 'message', data: res.data);
      }
    } catch (e) {
      await _handleException(e);
    }
  }

  @override
  Future<dynamic> post({
    required String path,
    dynamic body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response res = await dio.post(
        path,
        data: body,
        options: Options(headers: header),
        queryParameters: queryParameter,
      );
      var statusCode = res.statusCode;
      if (statusCode! >= 200 && statusCode < 300) {
        //sucess
        return res.data;
      } else {
        //failure
        throw ServerException(message: res.statusMessage ?? '', data: res.data);
      }
    } catch (e) {
      await _handleException(e);
    }
  }

  Future<void> _handleException(e) async {
    PrintManager.printError(e.toString());
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ServerException(
            message: 'Connection timed out. Please check your internet.',
            data: {'error': e.error.toString(), 'type': 'connectionTimeout'},
          );
        case DioExceptionType.sendTimeout:
          throw ServerException(
            message: 'Request timed out. Please try again.',
            data: {'error': e.error.toString(), 'type': 'sendTimeout'},
          );
        case DioExceptionType.receiveTimeout:
          throw ServerException(
            message: 'Server took too long to respond. Please try again.',
            data: {'error': e.error.toString(), 'type': 'receiveTimeout'},
          );
        case DioExceptionType.badCertificate:
          throw ServerException(
            message: 'SSL certificate error.',
            data: {'error': e.error.toString(), 'type': 'badCertificate'},
          );
        case DioExceptionType.badResponse:
          // Extract the real server response body so the error message
          // (e.g. "email already exists") can be passed up to the UI.
          final responseData = e.response?.data;
          final data = responseData is Map<String, dynamic>
              ? responseData
              : {
                  'error': responseData?.toString() ?? 'Unknown error',
                  'type': 'badResponse',
                };
          throw ServerException(
            message: e.response?.statusMessage ?? e.message ?? 'Server error.',
            data: data,
          );
        case DioExceptionType.cancel:
          throw ServerException(
            message: 'Request was cancelled.',
            data: {'error': e.error.toString(), 'type': 'cancel'},
          );
        case DioExceptionType.connectionError:
          throw ServerException(
            message: 'No internet connection. Please check your network.',
            data: {'error': e.error.toString(), 'type': 'connectionError'},
          );
        case DioExceptionType.unknown:
          throw ServerException(
            message: e.message ?? 'An unexpected error occurred.',
            data: {'error': e.error.toString(), 'type': 'unknown'},
          );
        case DioExceptionType.transformTimeout:
          throw ServerException(
            message: 'Response processing timed out.',
            data: {'error': e.error.toString(), 'type': 'transformTimeout'},
          );
      }
    } else if (e is ServerException) {
      // Re-throw ServerException directly (e.g. from the 2xx check above)
    } else {
      throw ServerException(
        message: e.toString(),
        data: {'error': e.toString(), 'type': 'unknown'},
      );
    }
  }
}
