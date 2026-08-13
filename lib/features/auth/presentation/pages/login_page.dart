import 'package:animoo/core/constants/animation_constants.dart';
import 'package:animoo/core/router/app_router.dart';
import 'package:animoo/core/theme/app_colors.dart';
import 'package:animoo/core/theme/app_fonts.dart';
import 'package:animoo/core/utils/validators.dart';
import 'package:animoo/shared/widgets/custom_button.dart';
import 'package:animoo/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Form(
                  key: _formKey,
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.status == LoginStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login Successful!'),
                            backgroundColor: AppColors.validationPass,
                          ),
                        );
                        context.go(AppRouter.home);
                      } else if (state.status == LoginStatus.failure &&
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h),
                          Hero(
                            tag: AnimationConstants.appLogoHeroTag,
                            createRectTween: (begin, end) {
                              return MaterialRectArcTween(
                                begin: begin,
                                end: end,
                              );
                            },
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 72.w,
                              height: 93.h,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 72.w,
                                  height: 72.h,
                                  color: AppColors.surfaceFill,
                                  child: const Icon(
                                    Icons.image,
                                    color: AppColors.textSubtitle,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),

                          // Log In Title
                          Text('Log In', style: AppFonts.loginTitle),
                          SizedBox(height: 0.h),

                          // Email Field
                          CustomTextField(
                            label: 'Email',
                            hint: 'Enter your email address',
                            controller: _emailController,
                            validator: AppValidators.validateEmail,
                          ),
                          Builder(
                            builder: (context) {
                              _emailController.addListener(() {
                                context.read<LoginCubit>().emailChanged(
                                  _emailController.text,
                                );
                              });
                              return const SizedBox.shrink();
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Password Field
                          CustomTextField(
                            label: 'Password',
                            hint: '********',
                            controller: _passwordController,
                            isPassword: true,
                            validator: AppValidators.validatePassword,
                          ),
                          Builder(
                            builder: (context) {
                              _passwordController.addListener(() {
                                context.read<LoginCubit>().passwordChanged(
                                  _passwordController.text,
                                );
                              });
                              return const SizedBox.shrink();
                            },
                          ),

                          SizedBox(height: 12.h),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context.push(AppRouter.forgotPassword);
                              },
                              child: Text(
                                'Forgot Password..?',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.primaryAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Login Button
                          CustomButton(
                            text: 'Log In',
                            isLoading: state.status == LoginStatus.submitting,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().submit();
                              }
                            },
                          ),

                          Spacer(),
                          // Sign Up Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.textSubtitle,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push(AppRouter.signup);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: AppColors.primaryAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
