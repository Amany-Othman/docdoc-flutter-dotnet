import 'dart:async';
import 'package:flutter/material.dart';
import '../services/auth_session.dart';
import '../widgets/docdoc_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));

    await AuthSession.instance.restoreSession();

    if (!mounted) return;

    if (AuthSession.instance.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DocdocLogo(
          fontSize: 32,
          iconSize: 36,
        ),
      ),
    );
  }
}
