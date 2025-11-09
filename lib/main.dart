import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';
import 'package:weather_app/views/screens/landing_page.dart';
import 'package:weather_app/views/screens/try.dart';
import 'package:weather_app/views/screens/yourLocation_screen.dart';
import 'package:weather_app/views/widgets/responsive_file.dart';
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF137FEC),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF137FEC),
          brightness: Brightness.dark,
        ),
      ),
      home:  WeatherLandingPage(),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CurrentWeatherProvider()),
      ],
      child: ResponsiveWrapper(child: app) ,
    );
  }
}
