import 'package:json_annotation/json_annotation.dart';

part 'failure_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class FailureModel {
  final int statusCode;
  final List<String> error;

  FailureModel({required this.statusCode, required this.error});

  factory FailureModel.fromJson(Map<String, dynamic> json) =>
      _$FailureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FailureModelToJson(this);
}
