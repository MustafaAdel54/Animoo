import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      isEmailValid: _validateEmail(value),
      status: LoginStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      isPasswordValid: value.isNotEmpty,
      status: LoginStatus.initial,
    ));
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> submit() async {
    final bool isEmailValid = _validateEmail(state.email);
    final bool isPasswordValid = state.password.isNotEmpty;

    if (!isEmailValid || !isPasswordValid) {
      emit(state.copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        errorMessage: 'Please check your inputs.',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.submitting));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Call actual AuthRepository here
      
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Login failed. Please try again.',
      ));
    }
  }
}
