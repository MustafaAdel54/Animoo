import 'package:json_annotation/json_annotation.dart';

part 'failure_model.g.dart';

int _parseStatusCode(dynamic value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

List<String> _parseError(dynamic value) {
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  } else if (value is String) {
    return [value];
  }
  return [];
}

@JsonSerializable(createJsonSchema: true)
class FailureModel {
  @JsonKey(fromJson: _parseStatusCode)
  final int statusCode;

  @JsonKey(fromJson: _parseError)
  final List<String> error;

  FailureModel({required this.statusCode, required this.error});

  factory FailureModel.fromJson(Map<String, dynamic> json) =>
      _$FailureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FailureModelToJson(this);
}
