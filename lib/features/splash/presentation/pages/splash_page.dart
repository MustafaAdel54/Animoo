import 'package:animoo/core/constants/animation_constants.dart';
import 'package:animoo/core/router/app_router.dart';
import 'package:animoo/core/theme/app_colors.dart';
import 'package:animoo/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:animoo/features/splash/presentation/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..initSplash(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.completed) {
          context.go(AppRouter.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Center(
          child: Hero(
            tag: AnimationConstants.appLogoHeroTag,
            createRectTween: (begin, end) {
              return MaterialRectArcTween(begin: begin, end: end);
            },
            child: Image.asset(
              'assets/images/splash_logo_page.png',
              width: 192.w,
              height: 192.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
