import 'package:animoo/core/database/api/api_consts.dart';
import 'package:animoo/core/database/api/dio_services.dart';
import 'package:animoo/core/error/failure_model.dart';
import 'package:animoo/core/error/server_exception.dart';
import 'package:animoo/core/service/get_it_service.dart';
import 'package:animoo/core/utils/extensions.dart';
import 'package:animoo/models/auth/auth_response_model.dart';
import 'package:animoo/models/auth/sign_up_request_model.dart';
import 'package:animoo/models/auth/verification_response_model.dart';
import 'package:dartz/dartz.dart';

class AuthApi {
  Future<Either<FailureModel, AuthResponseModel>> signup(
    SignUpRequestModel signupRequest,
  ) async {
    try {
      DioServices dioServices = getIt.dioService;
      var res = await dioServices.post(
        path: ApiConsts.signUpEndPoint,
        body: await signupRequest.toFormData(),
      );
      return Right(AuthResponseModel.fromJson(res));
    } on ServerException catch (e) {
      return Left(FailureModel.fromJson(Map<String, dynamic>.from(e.data)));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          'statusCode': '1000',
          'error': [e.toString()],
        }),
      );
    }
  }

  Future<Either<FailureModel, VerificationResponseModel>> verification({
    required String email,
    required String code,
  }) async {
    try {
      DioServices dioServices = getIt.dioService;
      var res = await dioServices.post(
        path: ApiConsts.verificationCodeEndPoint,
        body: {'email': email, 'code': code},
      );
      return Right(VerificationResponseModel.fromJson(res));
    } on ServerException catch (e) {
      return Left(FailureModel.fromJson(Map<String, dynamic>.from(e.data)));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          'statusCode': '1000',
          'error': [e.toString()],
        }),
      );
    }
  }
}
