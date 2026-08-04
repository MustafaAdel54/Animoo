import 'dart:io';

import 'package:dio/dio.dart';

class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final File image;

  const SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
  }
}
