import 'package:flutter/material.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    bool loginState = await AuthController.isUserLoggedIn();

    if (mounted) {
      if (loginState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AppBackground(
      child: Center(
        child: AppLogo(),
      ),
    ));
  }
}
