import 'package:animoo/core/error/server_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/data/repositories/auth_repository.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final AuthRepository _authRepository;
  final String email;

  VerificationCubit({required this.email, AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const VerificationState());

  void codeChanged(String value) => emit(state.copyWith(code: value));

  Future<void> submit() async {
    if (state.status == VerificationStatus.submitting) return;
    emit(state.copyWith(status: VerificationStatus.submitting));
    try {
      await _authRepository.verifyCode(email: email, code: state.code);
      emit(state.copyWith(status: VerificationStatus.success));
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          status: VerificationStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerificationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> resendCode() async {
    if (state.status == VerificationStatus.resending ||
        state.status == VerificationStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: VerificationStatus.resending));
    try {
      await _authRepository.resendVerificationCode(email: email);
      emit(state.copyWith(status: VerificationStatus.resendSuccess));
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          status: VerificationStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerificationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
