import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/intro/intro_screen.dart';
import 'package:social_media/presentation/profile/profile_screen.dart';
import 'package:social_media/utils/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Lottie.asset("assets/animations/splashLoading.json"),
        ),
      ),
    );
  }
}

Future<void> checkUserLogin(context) async {
  final preferences = await SharedPreferences.getInstance();
  final userLoggedIn = preferences.get(authKey);
  debugPrint(userLoggedIn.toString());
  if (userLoggedIn == null || userLoggedIn == false) {
    await Future.delayed(const Duration(milliseconds:985));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const IntroScreen(),
    ));
  } else {
    await Future.delayed(const Duration(milliseconds: 985));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    ));
  }
}
