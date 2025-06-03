import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/appTheme/themeData.dart';
import 'package:weather_app/views/mainScreen/mainScreen.dart';
import 'package:weather_app/views/weatherScreen/weatherScreen.dart';
import 'package:weather_app/weatherWorld.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AnimatedSplashScreen(splash: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset('assets/animations/windAnimation.json',)), nextScreen: weatherScreen(),splashIconSize: 1900,),
    );
  }
}
