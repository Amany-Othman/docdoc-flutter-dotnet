import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
