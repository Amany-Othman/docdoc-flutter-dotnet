import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../models/speciality.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/booking_banner.dart';
import '../widgets/home/speciality_section.dart';
import '../widgets/home/doctor_section.dart';
import '../widgets/home/home_bottom_nav_bar.dart';
import '../services/auth_session.dart';

import 'all_specialities_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();

    _controller = HomeController();
    _controller.loadRecommendedDoctors();
    _controller.loadFeaturedSpecialities();
  }

  @override
  void dispose() {
    // This page's login/signup input controllers are already gone by now.
    // Here we just clean up this screen's own notifiers so nothing survives
    // once the user navigates away.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                HomeAppBar(
                  userName: AuthSession.instance.name ?? 'there',
                  hasNotification: _controller.hasUnreadNotifications,
                  onNotificationTap: _controller.markNotificationsRead,
                ),
                const SizedBox(height: 20),
                BookingBanner(
                  onFindNearbyTap: () {
                    // TODO: navigate to nearby-doctors screen
                  },
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<List<Speciality>>(
                  valueListenable: _controller.featuredSpecialities,
                  builder: (context, specialities, _) {
                    return SpecialitySection(
                      specialities: specialities,
                      onSeeAll: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AllSpecialitiesScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                DoctorSection(
                  doctorsListenable: _controller.recommendedDoctors,
                  onSeeAll: () {
                    // TODO: navigate to all doctors screen
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _controller.selectedNavIndex,
        onTap: _controller.changeNavIndex,
      ),
    );
  }
}
