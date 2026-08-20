import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../models/speciality.dart';
import '../services/api_service.dart';

class HomeController {
  final ValueNotifier<int> selectedNavIndex = ValueNotifier<int>(0);

  final ValueNotifier<bool> hasUnreadNotifications = ValueNotifier<bool>(true);

  final ValueNotifier<List<Doctor>> recommendedDoctors =
      ValueNotifier<List<Doctor>>(const []);

  final ValueNotifier<List<Speciality>> featuredSpecialities =
      ValueNotifier<List<Speciality>>(const []);

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

  Future<void> loadFeaturedSpecialities() async {
    try {
      final specialities = await ApiService.getFeaturedSpecialities();
      featuredSpecialities.value = specialities;
    } on ApiException {
      featuredSpecialities.value = const [];
    } catch (_) {
      featuredSpecialities.value = const [];
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
    featuredSpecialities.dispose();
  }
}
