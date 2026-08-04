import 'dart:io';

class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final File image;

  const SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.image,
  });

  Map<String, dynamic> tojson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'image': image,
    };
  }
}
