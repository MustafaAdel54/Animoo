// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      alert: json['alert'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'alert': instance.alert,
      'user': instance.user,
    };

const _$AuthResponseModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'statusCode': {'type': 'integer'},
    'message': {'type': 'string'},
    'alert': {'type': 'string'},
    'user': {r'$ref': r'#/$defs/UserModel'},
  },
  'required': ['statusCode', 'message', 'alert', 'user'],
  r'$defs': {
    'UserModel': {
      'type': 'object',
      'properties': {
        'id': {'type': 'integer'},
        'first_name': {'type': 'string'},
        'last_name': {'type': 'string'},
        'phone': {'type': 'string'},
        'email': {'type': 'string'},
        'image_path': {'type': 'string'},
        'is_verified': {'type': 'string'},
      },
      'required': [
        'id',
        'first_name',
        'last_name',
        'phone',
        'email',
        'image_path',
        'is_verified',
      ],
    },
  },
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  imagePath: json['image_path'] as String,
  isVerified: json['is_verified'] as String,
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

const _$UserModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'first_name': {'type': 'string'},
    'last_name': {'type': 'string'},
    'phone': {'type': 'string'},
    'email': {'type': 'string'},
    'image_path': {'type': 'string'},
    'is_verified': {'type': 'string'},
  },
  'required': [
    'id',
    'first_name',
    'last_name',
    'phone',
    'email',
    'image_path',
    'is_verified',
  ],
};
