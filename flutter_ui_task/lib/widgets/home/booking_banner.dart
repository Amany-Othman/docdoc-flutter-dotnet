import 'package:flutter/material.dart';

class BookingBanner extends StatelessWidget {
  final VoidCallback onFindNearbyTap;

  const BookingBanner({super.key, required this.onFindNearbyTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      clipBehavior: Clip.antiAlias, // keeps the doctor image inside the rounded corners
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF4E7FFF), Color(0xFF3D6BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/doctor_banner.png',
              height: 220, // taller so it bleeds off the edge like the mockup
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    'Book and schedule with nearest doctor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onFindNearbyTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF3D6BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Find Nearby'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}