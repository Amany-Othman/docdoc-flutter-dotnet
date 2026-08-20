import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomeAppBar extends StatelessWidget {
  final String userName;
  final ValueListenable<bool> hasNotification;
  final VoidCallback onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.userName,
    required this.hasNotification,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $userName!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              const Text(
                'How Are You Today?',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: hasNotification,
          builder: (context, hasUnread, _) {
            return GestureDetector(
              onTap: onNotificationTap,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                        12), // was 10, slightly roomier circle
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      size: 22,
                    ),
                  ),
                  if (hasUnread)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
