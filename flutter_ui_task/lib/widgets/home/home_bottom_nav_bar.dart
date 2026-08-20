import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomeBottomNavBar extends StatelessWidget {
  final ValueListenable<int> selectedIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _icons = [
    Icons.home_outlined,
    Icons.chat_bubble_outline,
    Icons.search, // center item, styled differently
    Icons.calendar_today_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, current, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_icons.length, (index) {
              final isCenter = index == 2;
              final isSelected = current == index;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3D6BFF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(_icons[index], color: Colors.white),
                  ),
                );
              }

              return IconButton(
                onPressed: () => onTap(index),
                icon: Icon(
                  _icons[index],
                  color: isSelected ? const Color(0xFF3D6BFF) : Colors.grey,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
