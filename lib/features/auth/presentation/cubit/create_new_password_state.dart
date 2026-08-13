import 'package:equatable/equatable.dart';

enum CreateNewPasswordStatus { initial, submitting, success, failure }

class CreateNewPasswordState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final CreateNewPasswordStatus status;
  final String? errorMessage;

  const CreateNewPasswordState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = CreateNewPasswordStatus.initial,
    this.errorMessage,
  });

  CreateNewPasswordState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    CreateNewPasswordStatus? status,
    String? errorMessage,
  }) {
    return CreateNewPasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, status, errorMessage];
}
