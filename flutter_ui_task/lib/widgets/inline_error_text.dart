import 'package:flutter/material.dart';

/// Small red error line shown under the form when the API call fails.
/// Renders nothing when there's no error, so screens can drop this in
/// unconditionally.
class InlineErrorText extends StatelessWidget {
  const InlineErrorText({super.key, required this.errorMessage});
  final ValueNotifier<String?> errorMessage;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: errorMessage,
      builder: (context, error, _) {
        if (error == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 13)),
        );
      },
    );
  }
}
