import 'package:flutter/material.dart';
import 'package:weather_app/views/screens/all.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      // themeMode: themeMode,
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
      ),
      // darkTheme: darkTheme,
      home: Navigation()
    );
  }
}
