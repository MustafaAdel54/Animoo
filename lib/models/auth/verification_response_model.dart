import 'package:animoo/models/auth/auth_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verification_response_model.g.dart';

@JsonSerializable()
class VerificationResponseModel {
  @JsonKey(fromJson: parseToInt)
  final int statusCode;
  @JsonKey(fromJson: parseString)
  final String message;
  @JsonKey(name: 'access_token', fromJson: parseString)
  final String accessToken;
  @JsonKey(name: 'refresh_token', fromJson: parseString)
  final String refreshToken;
  final UserModel user;

  VerificationResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory VerificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationResponseModelToJson(this);
}
