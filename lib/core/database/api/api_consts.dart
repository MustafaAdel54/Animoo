import 'package:envied/envied.dart';

part 'api_consts.g.dart';

@Envied(path: '.env')
abstract class ApiConsts {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _ApiConsts.baseUrl;
  @EnviedField(varName: 'SIGN_UP_ENDPOINT')
  static const String signUpEndPoint = _ApiConsts.signUpEndPoint;
  @EnviedField(varName: 'VERIFICATION_CODE_ENDPOINT')
  static const String verificationCodeEndPoint =
      _ApiConsts.verificationCodeEndPoint;
}
