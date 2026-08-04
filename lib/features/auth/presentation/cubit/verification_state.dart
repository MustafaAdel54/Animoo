import 'package:equatable/equatable.dart';

enum VerificationStatus {
  initial,
  submitting,
  resending,
  success,
  failure,
  resendSuccess,
}

class VerificationState extends Equatable {
  final String code;
  final VerificationStatus status;
  final String? errorMessage;

  const VerificationState({
    this.code = '',
    this.status = VerificationStatus.initial,
    this.errorMessage,
  });

  VerificationState copyWith({
    String? code,
    VerificationStatus? status,
    String? errorMessage,
  }) {
    return VerificationState(
      code: code ?? this.code,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, status, errorMessage];
}
