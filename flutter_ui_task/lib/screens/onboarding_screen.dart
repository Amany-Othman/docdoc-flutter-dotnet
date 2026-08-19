import 'package:flutter/material.dart';
import '../widgets/docdoc_logo.dart';
import '../widgets/onboarding_image.dart';
import '../widgets/app_primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const DocdocLogo(),
              const SizedBox(height: 24),
              const Expanded(child: OnboardingImage()),
              const SizedBox(height: 24),
              const Text(
                'Best Doctor\nAppointment App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F80ED),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 24),
              AppPrimaryButton(
                label: 'Get Started',
                onPressed: () => Navigator.pushNamed(context, '/signIn'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
