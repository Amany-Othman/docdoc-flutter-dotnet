import 'package:flutter/foundation.dart';

import '../models/speciality.dart';
import '../services/api_service.dart';

class AllSpecialitiesController {
  final ValueNotifier<List<Speciality>> specialities =
      ValueNotifier<List<Speciality>>(const []);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  Future<void> loadSpecialities() async {
    isLoading.value = true;

    try {
      final result = await ApiService.getAllSpecialities();
      specialities.value = result;
    } catch (_) {
      // Keep it simple for now, same approach as HomeController -
      // an empty list just means the screen shows its empty state.
      specialities.value = const [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Called from the screen's dispose(). Frees the notifiers now that
  /// this page is done - nothing here needs to survive navigation away.
  void dispose() {
    specialities.dispose();
    isLoading.dispose();
  }
}
