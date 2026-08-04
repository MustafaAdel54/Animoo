// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResponseModel _$VerificationResponseModelFromJson(
  Map<String, dynamic> json,
) => VerificationResponseModel(
  statusCode: parseToInt(json['statusCode']),
  message: parseString(json['message']),
  accessToken: parseString(json['access_token']),
  refreshToken: parseString(json['refresh_token']),
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VerificationResponseModelToJson(
  VerificationResponseModel instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'user': instance.user,
};
