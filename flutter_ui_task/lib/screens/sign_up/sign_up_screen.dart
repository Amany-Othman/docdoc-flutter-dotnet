import 'package:flutter/material.dart';
import '../../controllers/sign_up_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/social_login_row.dart';
import '../../widgets/auth_footer_link.dart';
import '../../widgets/inline_error_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = SignUpController();

  @override
  void dispose() {
    // Same reasoning as Sign In - once this screen is gone, the typed
    // name/email/password/phone and every notifier are released.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final success = await _controller.signUp();
    if (success && mounted) {
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
                title: 'Create Account',
                subtitle:
                    'Sign up now and start exploring all that our app has to offer. We are excited to welcome you to our community!',
              ),
              const SizedBox(height: 28),
              AppTextField(
                  controller: _controller.nameController, hint: 'Full name'),
              const SizedBox(height: 14),
              AppTextField(
                  controller: _controller.emailController, hint: 'Email'),
              const SizedBox(height: 14),
              ValueListenableBuilder<bool>(
                valueListenable: _controller.obscurePassword,
                builder: (context, obscure, _) {
                  return AppTextField(
                    controller: _controller.passwordController,
                    hint: 'Password',
                    obscureText: obscure,
                    suffixIcon: IconButton(
                      icon: Icon(obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: _controller.toggleObscurePassword,
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              AppTextField(
                controller: _controller.phoneController,
                hint: 'Your phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                      widthFactor: 1,
                      child: Text('🇪🇬', style: TextStyle(fontSize: 18))),
                ),
              ),
              const SizedBox(height: 12),
              InlineErrorText(errorMessage: _controller.errorMessage),
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isLoading,
                builder: (context, loading, _) {
                  return AppPrimaryButton(
                    label: 'Create Account',
                    isLoading: loading,
                    onPressed: _handleSignUp,
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
                actionLabel: 'Sign In',
                onTap: () => Navigator.pushNamed(context, '/signIn'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
