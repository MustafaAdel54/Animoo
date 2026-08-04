// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResponseModel _$VerificationResponseModelFromJson(
  Map<String, dynamic> json,
) => VerificationResponseModel(
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
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
