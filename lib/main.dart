import 'package:flutter/material.dart';
import 'package:weather_app/utilities/appTheme/themeData.dart';
import 'package:weather_app/views/mainScreen/mainScreen.dart';
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
      home: MainScreen(),
    );
  }
}
