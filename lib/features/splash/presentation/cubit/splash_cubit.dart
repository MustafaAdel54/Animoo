import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animoo/core/constants/animation_constants.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> initSplash() async {
    emit(state.copyWith(status: SplashStatus.loading));
    await Future.delayed(AnimationConstants.splashDelay);
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
