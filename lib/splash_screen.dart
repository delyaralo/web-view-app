import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'myhomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 4000,
          splashIconSize: double.infinity,
          // backgroundColor: Colors.red,
          splash: Image.asset(
            'assets/splashscreenapp.png',
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          nextScreen: const MyHomePage()),
    );
  }
}
