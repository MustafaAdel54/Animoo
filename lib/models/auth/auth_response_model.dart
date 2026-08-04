import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

int parseToInt(dynamic value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

String parseString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(fromJson: parseToInt)
  final int statusCode;
  @JsonKey(fromJson: parseString)
  final String message;
  @JsonKey(fromJson: parseString)
  final String alert;
  final UserModel user;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.alert,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(fromJson: parseToInt)
  final int id;
  @JsonKey(name: 'first_name', fromJson: parseString)
  final String firstName;
  @JsonKey(name: 'last_name', fromJson: parseString)
  final String lastName;
  @JsonKey(fromJson: parseString)
  final String phone;
  @JsonKey(fromJson: parseString)
  final String email;
  @JsonKey(name: 'image_path', fromJson: parseString)
  final String imagePath;
  @JsonKey(name: 'is_verified', fromJson: parseString)
  final String isVerified;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.imagePath,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
