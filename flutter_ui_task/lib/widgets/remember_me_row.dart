import 'package:flutter/material.dart';

/// Isolated in its own widget + own ValueNotifier so ticking the
/// checkbox only rebuilds this row, not the whole Sign In screen.
class RememberMeRow extends StatelessWidget {
  const RememberMeRow({super.key, required this.rememberMe, required this.onForgotPassword});

  final ValueNotifier<bool> rememberMe;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: rememberMe,
              builder: (context, value, _) {
                return Checkbox(
                  value: value,
                  onChanged: (v) => rememberMe.value = v ?? false,
                );
              },
            ),
            const Text('Remember me', style: TextStyle(fontSize: 13)),
          ],
        ),
        TextButton(onPressed: onForgotPassword, child: const Text('Forgot Password?')),
      ],
    );
  }
}
