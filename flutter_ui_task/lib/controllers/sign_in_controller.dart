import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_session.dart';
import '../services/secure_storage_service.dart';

/// Owns everything the Sign In screen needs.
class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> rememberMe = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Returns true on success.
  Future<bool> login() async {
    errorMessage.value = null;
    isLoading.value = true;

    try {
      final result = await ApiService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      AuthSession.instance.setSession(
        token: result.token,
        role: result.role,
      );

      // Save the token only if Remember Me is checked.
      if (rememberMe.value) {
        await SecureStorageService.saveToken(result.token);
      } else {
        await SecureStorageService.deleteToken();
      }

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

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.dispose();
    rememberMe.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
