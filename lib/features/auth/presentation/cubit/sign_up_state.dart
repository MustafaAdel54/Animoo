import 'dart:io';

import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, submitting, success, failure }

class SignUpState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final File? image;
  final SignUpStatus status;
  final String? errorMessage;

  // Live password rule checks
  bool get hasMinLength => password.length >= 12;

  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));

  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));

  bool get hasSpecialChar =>
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  bool get hasNumber => password.contains(RegExp(r'[0-9]'));

  bool get isPasswordStrong =>
      hasMinLength && hasUppercase && hasLowercase && hasSpecialChar &&
          hasNumber;

  const SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.image,
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    File? image,
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      image: image ?? this.image,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        firstName,
        lastName,
        email,
        phone,
        password,
        confirmPassword,
        image,
        status,
        errorMessage,
      ];
}
