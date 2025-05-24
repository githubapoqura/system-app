import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/introduction/introduction.dart';
import 'package:untitled4/ui/Screens/student/student.dart';
import 'package:untitled4/ui/Screens/introduction/second_introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  static const String routeName = "splash";
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () async {
      final prefs = await SharedPreferences.getInstance();
      final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        prefs.setBool('isFirstTime', false);
        Navigator.pushReplacementNamed(context, Introduction.routeName);
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
