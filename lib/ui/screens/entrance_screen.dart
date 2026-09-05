import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'login_screen_placeholder.dart';

class AnimatedEntranceScreen extends StatefulWidget {
  const AnimatedEntranceScreen({super.key});

  @override
  State<AnimatedEntranceScreen> createState() => _AnimatedEntranceScreenState();
}

class _AnimatedEntranceScreenState extends State<AnimatedEntranceScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // Wait 2 seconds to show the logo
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      // Use a standard pushReplacement to the signup page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Remove the native splash screen as soon as this widget is first painted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D12),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/branding/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.blur_on, color: Colors.white, size: 100);
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'SHROWD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
