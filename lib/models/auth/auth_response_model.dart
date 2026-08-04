// "statusCode": 201,
//  "message": "Signup successful!",
// "alert": "We send verfication code to your email",
// "user": {
// "id": 1,
//         "first_name": "ahmed",
//         "last_name": "elsaid",
//         "email": "ahmed122727727@gmail.com",
//         "phone": "201001398831",
//         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
//         "is_verified": "false"
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class AuthResponseModel {
  final int statusCode;
  final String message;
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

@JsonSerializable(createJsonSchema: true)
class UserModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String phone;
  final String email;
  @JsonKey(name: 'image_path')
  final String imagePath;
  @JsonKey(name: 'is_verified')
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
