import 'package:flutter/material.dart';
import '../../controllers/sign_in_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/social_login_row.dart';
import '../../widgets/auth_footer_link.dart';
import '../../widgets/remember_me_row.dart';
import '../../widgets/inline_error_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _controller = SignInController();

  @override
  void dispose() {
    // Screen is leaving the widget tree - wipe the typed email/password
    // and every notifier this controller was holding.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await _controller.login();
    if (success && mounted) {
      // pushReplacementNamed removes THIS screen from the stack, which
      // triggers dispose() above - so nothing from the login form is
      // still sitting in memory once we're on the home screen.
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AuthHeader(
                title: 'Welcome Back',
                subtitle:
                    "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
              ),
              const SizedBox(height: 28),
              AppTextField(controller: _controller.emailController, hint: 'Email'),
              const SizedBox(height: 14),
              ValueListenableBuilder<bool>(
                valueListenable: _controller.obscurePassword,
                builder: (context, obscure, _) {
                  return AppTextField(
                    controller: _controller.passwordController,
                    hint: 'Password',
                    obscureText: obscure,
                    suffixIcon: IconButton(
                      icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: _controller.toggleObscurePassword,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              RememberMeRow(
                rememberMe: _controller.rememberMe,
                onForgotPassword: () {},
              ),
              const SizedBox(height: 4),
              InlineErrorText(errorMessage: _controller.errorMessage),
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isLoading,
                builder: (context, loading, _) {
                  return AppPrimaryButton(
                    label: 'Login',
                    isLoading: loading,
                    onPressed: _handleLogin,
                  );
                },
              ),
              const SizedBox(height: 24),
              const OrDivider(label: 'Or sign in with'),
              const SizedBox(height: 16),
              const SocialLoginRow(),
              const SizedBox(height: 20),
              AuthFooterLink(
                question: 'Already have an account yet? ',
                actionLabel: 'Sign Up',
                onTap: () => Navigator.pushNamed(context, '/signUp'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
