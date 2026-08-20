import 'package:flutter/material.dart';
import '../../models/speciality.dart';

class SpecialityItem extends StatelessWidget {
  final Speciality speciality;
  final VoidCallback? onTap;

  const SpecialityItem({super.key, required this.speciality, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: speciality.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(speciality.icon, color: speciality.iconColor),
          ),
          const SizedBox(height: 8),
          Text(speciality.label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
