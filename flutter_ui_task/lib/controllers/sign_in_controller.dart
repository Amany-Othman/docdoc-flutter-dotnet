import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_session.dart';

/// Owns everything the Sign In screen needs: the text controllers for
/// the input fields, and ValueNotifiers for anything the UI should
/// react to (loading spinner, error text, obscure-password toggle).
///
/// The screen just listens to these - it never manages state itself.
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

  /// Returns true on success. The screen decides what to do with that
  /// (navigate away), this controller only handles the request itself.
  Future<bool> login() async {
    errorMessage.value = null;
    isLoading.value = true;
    try {
      final result = await ApiService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      AuthSession.instance.setSession(token: result.token, role: result.role);
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

  /// Call this from the screen's State.dispose(). It wipes the typed
  /// email/password (and every notifier) from memory - once the user
  /// is past login, none of this needs to stick around.
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.dispose();
    rememberMe.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
