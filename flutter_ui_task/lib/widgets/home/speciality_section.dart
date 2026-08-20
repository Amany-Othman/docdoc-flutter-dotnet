import 'package:flutter/material.dart';
import '../../models/speciality.dart';
import 'speciality_item.dart';

class SpecialitySection extends StatelessWidget {
  final List<Speciality> specialities;
  final VoidCallback onSeeAll;

  const SpecialitySection({
    super.key,
    required this.specialities,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: 'Doctor Speciality', onSeeAll: onSeeAll),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              specialities.map((s) => SpecialityItem(speciality: s)).toList(),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(color: Color(0xFF3D6BFF), fontSize: 13),
          ),
        ),
      ],
    );
  }
}
