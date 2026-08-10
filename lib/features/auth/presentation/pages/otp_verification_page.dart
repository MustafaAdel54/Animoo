import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../cubit/verification_cubit.dart';
import '../cubit/verification_state.dart';

class OtpVerificationPage extends StatelessWidget {
  final String email;

  const OtpVerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerificationCubit(email: email),
      child: _OtpVerificationView(email: email),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  final String email;

  const _OtpVerificationView({required this.email});

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  final _pinController = TextEditingController();
  int _secondsLeft = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _pinController.addListener(() {
      context.read<VerificationCubit>().codeChanged(_pinController.text);
    });
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _resendCode() {
    if (_secondsLeft > 0) return;
    context.read<VerificationCubit>().resendCode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ── Pinput theme matching Figma ──────────────────────────────────────────
  PinTheme get _defaultTheme => PinTheme(
    width: 54.w,
    height: 53.h,
    textStyle: AppFonts.bodyLarge.copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: const Color(0xFFD6D6D6), width: 1),
    ),
  );

  PinTheme get _focusedTheme => _defaultTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primaryAccent, width: 1.5),
  );

  PinTheme get _submittedTheme => _defaultTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primaryAccent, width: 1.5),
    color: AppColors.primaryAccent.withValues(alpha: 0.06),
  );

  @override
  Widget build(BuildContext context) {
    final countdownText = _secondsLeft > 0
        ? 'Resend Code In 00:${_secondsLeft.toString().padLeft(2, '0')}'
        : 'Resend Code';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: BlocConsumer<VerificationCubit, VerificationState>(
            listenWhen: (previous, current) {
              return previous.status != current.status;
            },
            listener: (context, state) {
              if (state.status == VerificationStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Verification successful!'),
                    backgroundColor: AppColors.validationPass,
                  ),
                );
                context.go(AppRouter.home);
              } else if (state.status == VerificationStatus.resendSuccess) {
                _pinController.clear();
                setState(() => _secondsLeft = 59);
                _startCountdown();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verification code re-sent to your email.'),
                  ),
                );
              } else if (state.status == VerificationStatus.failure &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: AppColors.validationFail,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // ── Cancel Button ──────────────────────────────────────────
                  GestureDetector(
                    onTap: () => context.go(AppRouter.login),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 18.sp,
                          color: const Color(0xFF04332D),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Cancel',
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 20.sp,
                            color: const Color(0xFF04332D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // ── Title ──────────────────────────────────────────────────
                  Text(
                    'OTP Verification',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 20.sp,
                      color: const Color(0xFF04332D),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // ── Subtitle ───────────────────────────────────────────────
                  Text(
                    'Please enter the 5 digit code sent to your email address',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF212529).withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // ── Email Display ──────────────────────────────────────────
                  Text(
                    widget.email,
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.primaryAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // ── OTP Input (5 boxes as in Figma) ───────────────────────
                  Center(
                    child: Pinput(
                      controller: _pinController,
                      length: 5,
                      defaultPinTheme: _defaultTheme,
                      focusedPinTheme: _focusedTheme,
                      submittedPinTheme: _submittedTheme,
                      showCursor: true,
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 9.h),
                            width: 22.w,
                            height: 1,
                            color: AppColors.primaryAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // ── Confirm Button ─────────────────────────────────────────
                  CustomButton(
                    text: 'Confirm',
                    isLoading: state.status == VerificationStatus.submitting,
                    onPressed: () {
                      final code = _pinController.text;
                      if (code.length < 5) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter the full 5-digit code.',
                            ),
                          ),
                        );
                        return;
                      }
                      context.read<VerificationCubit>().submit();
                    },
                  ),
                  SizedBox(height: 16.h),

                  // ── Resend Countdown / Button ─────────────────────────────
                  Center(
                    child: state.status == VerificationStatus.resending
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              color: AppColors.primaryAccent,
                              strokeWidth: 2,
                            ),
                          )
                        : TextButton(
                            onPressed:
                                (_secondsLeft == 0 &&
                                    state.status !=
                                        VerificationStatus.submitting)
                                ? _resendCode
                                : null,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              countdownText,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: _secondsLeft == 0
                                    ? AppColors.primaryAccent
                                    : const Color(
                                        0xFF180901,
                                      ).withValues(alpha: 0.91),
                                fontWeight: _secondsLeft == 0
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
