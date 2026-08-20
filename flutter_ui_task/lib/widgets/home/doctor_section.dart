import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/doctor.dart';
import 'doctor_card.dart';

class DoctorSection extends StatelessWidget {
  final ValueListenable<List<Doctor>> doctorsListenable;
  final VoidCallback onSeeAll;

  const DoctorSection({
    super.key,
    required this.doctorsListenable,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommendation Doctor',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                'See All',
                style: TextStyle(color: Color(0xFF3D6BFF), fontSize: 13),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<List<Doctor>>(
          valueListenable: doctorsListenable,
          builder: (context, doctors, _) {
            if (doctors.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Column(
              children: doctors.map((d) => DoctorCard(doctor: d)).toList(),
            );
          },
        ),
      ],
    );
  }
}
