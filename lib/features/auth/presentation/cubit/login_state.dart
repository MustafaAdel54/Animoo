import 'package:equatable/equatable.dart';

enum LoginStatus { initial, submitting, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final bool isEmailValid;
  final bool isPasswordValid;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.isEmailValid = true,
    this.isPasswordValid = true,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        isEmailValid,
        isPasswordValid,
      ];
}
