import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_session.dart';

class SignUpController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<bool> signUp() async {
    errorMessage.value = null;
    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      // Step 1: create the account. The backend's /register endpoint
      // only confirms creation - it doesn't hand back a token.
      await ApiService.register(
        email: email,
        password: password,
        mobile: phoneController.text.trim(),
      );

      // Step 2: log the brand-new account in immediately, using the
      // same credentials, so the user lands on the home screen already
      // signed in instead of being sent back to a login form.
      final loginResult = await ApiService.login(email: email, password: password);
      AuthSession.instance.setSession(token: loginResult.token, role: loginResult.role);

      return true;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      return false;
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Same idea as SignInController.dispose() - clears the typed
  /// email/password/phone from memory once this screen is gone.
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    obscurePassword.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
