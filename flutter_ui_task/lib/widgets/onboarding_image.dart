import 'package:flutter/material.dart';

/// Shows the doctor photo once you've added assets/images/doctor.png.
/// Falls back to a placeholder icon so the app never crashes if the
/// image hasn't been added yet.
class OnboardingImage extends StatelessWidget {
  const OnboardingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/doctor.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.person, size: 120, color: Colors.grey.shade400);
        },
      ),
    );
  }
}
