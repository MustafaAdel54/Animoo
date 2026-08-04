// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailureModel _$FailureModelFromJson(Map<String, dynamic> json) => FailureModel(
  statusCode: _parseStatusCode(json['statusCode']),
  error: _parseError(json['error']),
);

Map<String, dynamic> _$FailureModelToJson(FailureModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'error': instance.error,
    };

const _$FailureModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'statusCode': {'type': 'integer'},
    'error': {
      'type': 'array',
      'items': {'type': 'string'},
    },
  },
  'required': ['statusCode', 'error'],
};
