import 'dart:io';

class AuthRepository {
  AuthRepository();

  /// Mock method: Creates a new user with email/password, uploads their profile photo,
  /// and stores all sign-up data. Simulated with a delay.
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    File? profileImage,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // In a real backend implementation, you would throw an exception if the email already exists,
    // or return the created user token.
  }

  /// Mock method: Signs in with email and password. Simulated with a delay.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
  }

  /// Mock method: Sends a password reset email to the specified address. Simulated with a delay.
  Future<void> sendPasswordResetEmail({required String email}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
  }

  /// Mock method: Checks if an email is already registered. Simulated with a delay.
  Future<bool> isEmailRegistered(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Always returning true for the mock to allow the reset password flow to proceed, 
    // or you could add specific logic to toggle this for testing.
    return true; 
  }

  /// Mock method: Signs out the current user.
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
