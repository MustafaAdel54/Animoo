import 'package:animoo/core/error/server_exception.dart';
import 'package:animoo/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  final AuthRepository _authRepository;

  CreateNewPasswordCubit({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const CreateNewPasswordState());

  void emailChanged(String value) => emit(state.copyWith(email: value));

  void passwordChanged(String value) => emit(state.copyWith(password: value));

  void confirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value));

  Future<void> submit() async {
    if (state.status == CreateNewPasswordStatus.submitting) return;
    emit(state.copyWith(status: CreateNewPasswordStatus.submitting));
    try {
      await _authRepository.createNewPassword(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      );
      emit(state.copyWith(status: CreateNewPasswordStatus.success));
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          status: CreateNewPasswordStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
