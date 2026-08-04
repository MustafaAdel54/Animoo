import 'dart:io';

import 'package:animoo/core/error/server_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/data/repositories/auth_repository.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const SignUpState());

  void firstNameChanged(String value) => emit(state.copyWith(firstName: value));

  void lastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void emailChanged(String value) => emit(state.copyWith(email: value));

  void phoneChanged(String value) => emit(state.copyWith(phone: value));

  // Emitting on every keystroke drives the live password checklist
  void passwordChanged(String value) => emit(state.copyWith(password: value));

  void confirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value));

  void imageChanged(File image) => emit(state.copyWith(image: image));

  Future<void> submit() async {
    if (state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.signUp(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        phone: state.phone,
        password: state.password,
        image: state.image!,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
