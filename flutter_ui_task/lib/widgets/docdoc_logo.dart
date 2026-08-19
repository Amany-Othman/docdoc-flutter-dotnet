import 'package:flutter/material.dart';

class DocdocLogo extends StatelessWidget {
  const DocdocLogo({super.key, this.fontSize = 20, this.iconSize = 24});
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_box_rounded, color: Colors.blue.shade600, size: iconSize),
        const SizedBox(width: 6),
        Text('Docdoc', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
