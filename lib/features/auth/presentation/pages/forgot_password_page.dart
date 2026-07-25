import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      context.read<ForgotPasswordCubit>().emailChanged(_emailController.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Form(
            key: _formKey,
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state.status == ForgotPasswordStatus.success) {
                  // Navigate to Create New Password page directly
                  context.push(AppRouter.createNewPassword);
                } else if (state.status == ForgotPasswordStatus.failure &&
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

                    // ── Back Button ────────────────────────────────────────
                    GestureDetector(
                      onTap: () => context.pop(),
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
                            'Back',
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20.sp,
                              color: const Color(0xFF04332D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // ── Title ──────────────────────────────────────────────
                    Text(
                      'Forget Your Password ?',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20.sp,
                        color: const Color(0xFF04332D),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // ── Subtitle ───────────────────────────────────────────
                    Text(
                      "Please enter the email address associated with your account, and we'll send you OTP to reset your password.",
                      style: AppFonts.bodyMedium.copyWith(
                        color: const Color(0xFF696969),
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // ── Email Input Field ──────────────────────────────────
                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email address',
                      controller: _emailController,
                      validator: AppValidators.validateEmail,
                    ),
                    SizedBox(height: 32.h),

                    // ── Send Code Button ───────────────────────────────────
                    CustomButton(
                      text: 'Send Code',
                      isLoading: state.status == ForgotPasswordStatus.submitting,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgotPasswordCubit>().submit();
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
