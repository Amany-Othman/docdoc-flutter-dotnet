import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../models/speciality.dart';
import '../services/api_service.dart';

class HomeController {
  final ValueNotifier<int> selectedNavIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> hasUnreadNotifications = ValueNotifier<bool>(true);
  final ValueNotifier<List<Doctor>> recommendedDoctors =
      ValueNotifier<List<Doctor>>(const []);

  final List<Speciality> specialities = const [
    Speciality(
      label: 'General',
      icon: Icons.medical_services_outlined,
      backgroundColor: Color(0xFFEFF3FF),
      iconColor: Color(0xFF4E7FFF),
    ),
    Speciality(
      label: 'Neurologic',
      icon: Icons.psychology_outlined,
      backgroundColor: Color(0xFFFFEDED),
      iconColor: Color(0xFFFF5A5A),
    ),
    Speciality(
      label: 'Pediatric',
      icon: Icons.child_care_outlined,
      backgroundColor: Color(0xFFFFEEF5),
      iconColor: Color(0xFFFF6FA5),
    ),
    Speciality(
      label: 'Radiology',
      icon: Icons.favorite_border,
      backgroundColor: Color(0xFFEDEBFF),
      iconColor: Color(0xFF8A6BFF),
    ),
  ];

  Future<void> loadRecommendedDoctors() async {
    try {
      final doctors = await ApiService.getRecommendedDoctors();
      recommendedDoctors.value = doctors;
    } on ApiException {
      // Keep it simple for now - empty list means DoctorSection
      // just shows its loading/empty state instead of crashing.
      recommendedDoctors.value = const [];
    } catch (_) {
      recommendedDoctors.value = const [];
    }
  }

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void markNotificationsRead() {
    hasUnreadNotifications.value = false;
  }

  /// Called from the screen's dispose(). Frees the notifiers now that
  /// this page is done - nothing here needs to survive navigation away.
  void dispose() {
    selectedNavIndex.dispose();
    hasUnreadNotifications.dispose();
    recommendedDoctors.dispose();
  }
}
