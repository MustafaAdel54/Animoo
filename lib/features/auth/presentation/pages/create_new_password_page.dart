import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../cubit/create_new_password_cubit.dart';
import '../cubit/create_new_password_state.dart';

class CreateNewPasswordPage extends StatelessWidget {
  final String email;

  const CreateNewPasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateNewPasswordCubit()..emailChanged(email),
      child: _CreateNewPasswordView(email: email),
    );
  }
}

class _CreateNewPasswordView extends StatefulWidget {
  final String email;

  const _CreateNewPasswordView({required this.email});

  @override
  State<_CreateNewPasswordView> createState() =>
      _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<_CreateNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasSpecial = false;
  bool _hasNumber = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordValidation);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordValidation() {
    final password = _passwordController.text;
    setState(() {
      _isMinLength = password.length >= 12;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasSpecial = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
  }

  Widget _buildValidationRule(String text, bool isValid) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isValid ? const Color(0xFF08A43A) : const Color(0xFFFC1B1A),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: isValid ? const Color(0xFF08A43A) : const Color(0xFFFC1B1A),
            ),
          ),
        ],
      ),
    );
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
            child: BlocConsumer<CreateNewPasswordCubit, CreateNewPasswordState>(
              listener: (context, state) {
                if (state.status == CreateNewPasswordStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully!'),
                      backgroundColor: AppColors.validationPass,
                    ),
                  );
                  context.go(AppRouter.login);
                } else if (state.status == CreateNewPasswordStatus.failure &&
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
                      'Create New Password',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20.sp,
                        color: const Color(0xFF04332D),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // ── New Password Field ─────────────────────────────────────
                    CustomTextField(
                      label: 'New Password',
                      hint: '********',
                      controller: _passwordController,
                      isPassword: true,
                      validator: AppValidators.validateStrongPassword,
                    ),
                    SizedBox(height: 8.h),

                    // ── Validation Rules ───────────────────────────────────────
                    Text(
                      'Please add all necessary characters to create safe password.',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFC1B1A),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 4.h,
                      children: [
                        _buildValidationRule('Minimum characters 12.', _isMinLength),
                        _buildValidationRule('One uppercase character.', _hasUppercase),
                        _buildValidationRule('One lowercase character.', _hasLowercase),
                        _buildValidationRule('One special character.', _hasSpecial),
                        _buildValidationRule('One number.', _hasNumber),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // ── Confirm Password Field ─────────────────────────────────
                    CustomTextField(
                      label: 'Confirm Password',
                      hint: '********',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) => AppValidators.confirmPasswordValidator(_passwordController.text)(value),
                    ),
                    SizedBox(height: 32.h),

                    // ── Submit Button ──────────────────────────────────────────
                    CustomButton(
                      text: 'Submit',
                      isLoading: state.status == CreateNewPasswordStatus.submitting,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<CreateNewPasswordCubit>();
                          cubit.passwordChanged(_passwordController.text);
                          cubit.confirmPasswordChanged(_confirmPasswordController.text);
                          cubit.submit();
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
