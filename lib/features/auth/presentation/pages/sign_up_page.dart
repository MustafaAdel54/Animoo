import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/password_rule_row.dart';
import '../cubit/sign_up_cubit.dart';
import '../cubit/sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(
      () => context.read<SignUpCubit>().firstNameChanged(
        _firstNameController.text,
      ),
    );
    _lastNameController.addListener(
      () =>
          context.read<SignUpCubit>().lastNameChanged(_lastNameController.text),
    );
    _emailController.addListener(
      () => context.read<SignUpCubit>().emailChanged(_emailController.text),
    );
    _phoneController.addListener(
      () => context.read<SignUpCubit>().phoneChanged(_phoneController.text),
    );
    _passwordController.addListener(
      () =>
          context.read<SignUpCubit>().passwordChanged(_passwordController.text),
    );
    _confirmPasswordController.addListener(
      () => context.read<SignUpCubit>().confirmPasswordChanged(
        _confirmPasswordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Show the Photo Source Bottom Sheet ──────────────────────────────────
  Future<void> _showImageSourceSheet() async {
    final cubit = context.read<SignUpCubit>();
    final picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ImageSourceSheet(
        onGallery: () async {
          Navigator.pop(context);
          final picked = await picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 80,
          );
          if (picked != null) cubit.imageChanged(File(picked.path));
        },
        onCamera: () async {
          Navigator.pop(context);
          final picked = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 80,
          );
          if (picked != null) cubit.imageChanged(File(picked.path));
        },
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
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state.status == SignUpStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Account created! Please verify your email.',
                      ),
                      backgroundColor: AppColors.validationPass,
                    ),
                  );
                  context.go(
                    '${AppRouter.otpVerification}?email=${Uri.encodeComponent(state.email)}',
                  );
                } else if (state.status == SignUpStatus.failure &&
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
                    SizedBox(height: 20.h),

                    // ── Logo ──────────────────────────────────────
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 72.w,
                        height: 93.h,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 72.w,
                          height: 72.h,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // ── Title ─────────────────────────────────────
                    Center(child: Text('Sign Up', style: AppFonts.loginTitle)),
                    SizedBox(height: 8.h),

                    // ── First Name ────────────────────────────────
                    CustomTextField(
                      label: 'First Name',
                      hint: 'Enter your First Name',
                      controller: _firstNameController,
                      validator: AppValidators.validateName,
                    ),
                    SizedBox(height: 16.h),

                    // ── Last Name ─────────────────────────────────
                    CustomTextField(
                      label: 'Last Name',
                      hint: 'Enter your Last Name',
                      controller: _lastNameController,
                      validator: AppValidators.validateName,
                    ),
                    SizedBox(height: 16.h),

                    // ── Email ─────────────────────────────────────
                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email address',
                      controller: _emailController,
                      validator: AppValidators.validateEmail,
                    ),
                    SizedBox(height: 16.h),

                    // ── Phone ─────────────────────────────────────
                    CustomTextField(
                      label: 'Phone',
                      hint: 'Enter your Phone',
                      controller: _phoneController,
                      validator: AppValidators.validatePhone,
                    ),
                    SizedBox(height: 16.h),

                    // ── Password ──────────────────────────────────
                    CustomTextField(
                      label: 'Password',
                      hint: '********',
                      controller: _passwordController,
                      isPassword: true,
                      validator: AppValidators.validateStrongPassword,
                    ),
                    SizedBox(height: 6.h),

                    // ── Live Password Checklist ───────────────────
                    _PasswordChecklist(state: state),
                    SizedBox(height: 16.h),

                    // ── Confirm Password ──────────────────────────
                    CustomTextField(
                      label: 'Confirm Password',
                      hint: '********',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: AppValidators.confirmPasswordValidator(
                        _passwordController.text,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Profile Image Picker ──────────────────────
                    Text(
                      'Upload Image For Your Profile',
                      style: AppFonts.inputLabel,
                    ),
                    SizedBox(height: 8.h),
                    _ProfileImagePicker(
                      pickedImage: state.image,
                      onTap: _showImageSourceSheet,
                    ),
                    SizedBox(height: 24.h),

                    // ── Sign Up Button ────────────────────────────
                    CustomButton(
                      text: 'Sign Up',
                      isLoading: state.status == SignUpStatus.submitting,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpCubit>().submit();
                        }
                      },
                    ),
                    SizedBox(height: 16.h),

                    // ── Already have an account? ──────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: RichText(
                          text: TextSpan(
                            style: AppFonts.bodyMedium.copyWith(
                              color: const Color(0xFF828282),
                            ),
                            children: [
                              const TextSpan(
                                text: 'Have an account already?  ',
                              ),
                              TextSpan(
                                text: 'Log in',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.primaryAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

// ── Image Source Bottom Sheet ────────────────────────────────────────────────
class _ImageSourceSheet extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  const _ImageSourceSheet({required this.onGallery, required this.onCamera});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Photo Gallery ──────────────────────────────────────────────
          _SheetButton(
            label: 'Photo Gallery',
            onTap: onGallery,
            textColor: AppColors.primaryAccent,
          ),
          SizedBox(height: 8.h),

          // ── Camera ─────────────────────────────────────────────────────
          _SheetButton(
            label: 'Camera',
            onTap: onCamera,
            textColor: AppColors.primaryAccent,
          ),
          SizedBox(height: 12.h),

          // ── Cancel ─────────────────────────────────────────────────────
          _SheetButton(
            label: 'Cancel',
            onTap: () => Navigator.pop(context),
            textColor: Colors.black87,
            backgroundColor: const Color(0xFFF0F0F0),
          ),
        ],
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;

  const _SheetButton({
    required this.label,
    required this.onTap,
    required this.textColor,
    this.backgroundColor = const Color(0xFFDEDEDE),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppFonts.bodyLarge.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ── Live Password Checklist Widget ──────────────────────────────────────────
class _PasswordChecklist extends StatelessWidget {
  final SignUpState state;

  const _PasswordChecklist({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.password.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 12.w,
      runSpacing: 6.h,
      children: [
        PasswordRuleRow(
          label: 'Minimum characters 12.',
          isPassing: state.hasMinLength,
        ),
        PasswordRuleRow(
          label: 'One uppercase character.',
          isPassing: state.hasUppercase,
        ),
        PasswordRuleRow(
          label: 'One lowercase character.',
          isPassing: state.hasLowercase,
        ),
        PasswordRuleRow(
          label: 'One special character.',
          isPassing: state.hasSpecialChar,
        ),
        PasswordRuleRow(label: 'One number.', isPassing: state.hasNumber),
      ],
    );
  }
}

// ── Profile Image Picker Widget ─────────────────────────────────────────────
class _ProfileImagePicker extends StatelessWidget {
  final File? pickedImage;
  final VoidCallback onTap;

  const _ProfileImagePicker({required this.pickedImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primaryAccent, width: 1),
        ),
        clipBehavior: Clip.hardEdge,
        child: pickedImage != null
            // Show the selected image as a preview
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(pickedImage!, fit: BoxFit.cover),
                  // Small "change photo" overlay icon
                  Positioned(
                    bottom: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ],
              )
            // Default placeholder state
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: AppColors.primaryAccent,
                    size: 28.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Select file',
                    style: AppFonts.bodyLarge.copyWith(
                      color: AppColors.primaryAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
