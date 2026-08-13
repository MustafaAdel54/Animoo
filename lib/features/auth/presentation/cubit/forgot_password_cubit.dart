import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const ForgotPasswordState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  Future<void> submit() async {
    if (state.status == ForgotPasswordStatus.submitting) return;
    emit(state.copyWith(status: ForgotPasswordStatus.submitting));

    try {
      // final isRegistered = await _authRepository.isEmailRegistered(state.email);
      // if (!isRegistered) {
      //   emit(
      //     state.copyWith(
      //       status: ForgotPasswordStatus.failure,
      //       errorMessage: 'This email is not signed up before.',
      //     ),
      //   );
      //   return;
      // }

      await _authRepository.forgetPassword(email: state.email);
      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
