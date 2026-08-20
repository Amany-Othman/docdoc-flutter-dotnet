import 'package:flutter/material.dart';

/// Represents a single doctor speciality (e.g. "General", "Neurologic").
///
/// Backed by GET api/Speciality (all) and GET api/Speciality/featured
/// (home screen subset) - see ApiService.
class Speciality {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const Speciality({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      label: json['label'] as String,
      icon: _iconFromKey(json['iconKey'] as String?),
      backgroundColor: _colorFromHex(json['backgroundColorHex'] as String?),
      iconColor: _colorFromHex(json['iconColorHex'] as String?),
    );
  }

  // Maps the backend's iconKey string to an actual IconData, since JSON
  // can't carry IconData directly. Add a case here whenever a new
  // speciality is added on the backend.
  static IconData _iconFromKey(String? key) {
    switch (key) {
      case 'general':
        return Icons.medical_services_outlined;
      case 'neurologic':
        return Icons.psychology_outlined;
      case 'pediatric':
        return Icons.child_care_outlined;
      case 'radiology':
        return Icons.favorite_border;
      case 'cardiology':
        return Icons.monitor_heart_outlined;
      case 'dermatology':
        return Icons.face_retouching_natural_outlined;
      case 'dental':
        return Icons.medical_information_outlined;
      case 'orthopedic':
        return Icons.accessibility_new_outlined;
      case 'ophthalmology':
        return Icons.visibility_outlined;
      case 'ent':
        return Icons.hearing_outlined;
      default:
        return Icons.local_hospital_outlined;
    }
  }

  // Parses a hex string like "#EFF3FF" into a Color.
  static Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) return const Color(0xFFEFF3FF);
    final cleaned = hex.replaceFirst('#', '');
    final withAlpha = cleaned.length == 6 ? 'ff$cleaned' : cleaned;
    return Color(int.parse(withAlpha, radix: 16));
  }
}
