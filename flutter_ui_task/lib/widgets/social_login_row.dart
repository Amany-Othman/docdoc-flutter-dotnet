import 'package:flutter/material.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialCircle(icon: Icons.g_mobiledata, color: Colors.red, onTap: () {}),
        const SizedBox(width: 16),
        _SocialCircle(icon: Icons.facebook, color: Colors.blue, onTap: () {}),
        const SizedBox(width: 16),
        _SocialCircle(icon: Icons.apple, color: Colors.black, onTap: () {}),
      ],
    );
  }
}

class _SocialCircle extends StatelessWidget {
  const _SocialCircle({required this.icon, required this.color, required this.onTap});

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
