// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      statusCode: parseToInt(json['statusCode']),
      message: parseString(json['message']),
      alert: parseString(json['alert']),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'alert': instance.alert,
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: parseToInt(json['id']),
  firstName: parseString(json['first_name']),
  lastName: parseString(json['last_name']),
  phone: parseString(json['phone']),
  email: parseString(json['email']),
  imagePath: parseString(json['image_path']),
  isVerified: parseString(json['is_verified']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'image_path': instance.imagePath,
  'is_verified': instance.isVerified,
};
