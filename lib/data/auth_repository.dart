import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:animoo/core/error/server_exception.dart';
import 'package:animoo/core/service/get_it_service.dart';
import 'package:animoo/core/utils/extensions.dart';
import 'package:animoo/data/auth_api.dart';
import 'package:animoo/models/auth/sign_up_request_model.dart';

class AuthRepository {
  AuthRepository();

  /// Creates a new user with email/password, uploads their profile photo,
  /// and stores all sign-up data.
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    File? image,
  }) async {
    // If no image provided, load the default user_icon from bundled assets
    final File profileImage;
    if (image != null) {
      profileImage = image;
    } else {
      final byteData = await rootBundle.load('assets/images/user_icon.png');
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/user_icon.png');
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      profileImage = tempFile;
    }

    final result = await AuthApi().signup(
      SignUpRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        image: profileImage,
      ),
    );

    // Fold: throw ServerException on failure so the cubit reads .message directly.
    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'Sign up failed.',
        data: {},
      ),
      (_) {}, // success — do nothing, let the cubit emit success
    );
  }

  /// Verifies the OTP code sent to the user's email after sign-up.
  /// On success, stores access & refresh tokens securely.
  Future<void> verifyCode({required String email, required String code}) async {
    final result = await AuthApi().verification(email: email, code: code);

    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'Verification failed.',
        data: {},
      ),
      (_) {}, // success — token storage handled below
    );

    // Store tokens securely (outside fold to properly await)
    if (result.isRight()) {
      final response = result.getOrElse(() => throw Exception('unreachable'));
      final tokenStorage = getIt.tokenStorageService;
      await tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    }
  }

  /// Resends a new verification code to the user's email.
  Future<void> resendVerificationCode({required String email}) async {
    final result = await AuthApi().resendVerificationCode(email: email);

    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'Failed to resend verification code.',
        data: {},
      ),
      (_) {}, // success — let the cubit emit resendSuccess
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    final result = await AuthApi().signIn(email: email, password: password);

    // Fold: throw ServerException on failure so the cubit reads .message directly.
    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'Login Failed.',
        data: {},
      ),
      (_) {},
    );

    // Store tokens securely (outside fold to properly await)
    if (result.isRight()) {
      final response = result.getOrElse(() => throw Exception('unreachable'));
      final tokenStorage = getIt.tokenStorageService;
      await tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    }
  }

  /// Mock method: Sends a password reset email to the specified address. Simulated with a delay.
  Future<void> forgetPassword({required String email}) async {
    final result = await AuthApi().forgetPassword(email: email);
    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'error in sending code',
        data: {},
      ),
      (_) {},
    );
  }

  Future<void> createNewPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final result = await AuthApi().createNewPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (failure) => throw ServerException(
        message: failure.error.isNotEmpty
            ? failure.error.join('\n')
            : 'Failed to create new password.',
        data: {},
      ),
      (_) {}, // success — token storage handled below
    );

    // Store tokens securely (outside fold to properly await)
    if (result.isRight()) {
      final response = result.getOrElse(() => throw Exception('unreachable'));
      final tokenStorage = getIt.tokenStorageService;
      await tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    }
  }

  /// Mock method: Checks if an email is already registered. Simulated with a delay.
  // Future<bool> isEmailRegistered(String email) async {
  //   // Simulate network delay
  //   await Future.delayed(const Duration(seconds: 1));
  //   // Always returning true for the mock to allow the reset password flow to proceed,
  //   // or you could add specific logic to toggle this for testing.
  //   return true;
  // }

  /// Mock method: Signs out the current user.
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
