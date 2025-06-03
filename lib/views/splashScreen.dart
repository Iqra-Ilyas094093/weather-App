import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/views/weatherScreen/weatherScreen.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset('assets/animations/cloudAnimation.json'),
        ),
        nextScreen: weatherScreen(),
        splashIconSize: 1900,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
