import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/appTheme/themeData.dart';
import 'package:weather_app/view_model/theme_view_model/theme_provider.dart';
import 'package:weather_app/views/mainScreen/mainScreen.dart';
import 'package:weather_app/views/splashScreen.dart';
import 'package:weather_app/views/weatherScreen/weatherScreen.dart';
import 'package:weather_app/weatherWorld.dart';

void main() {
  runApp(ProviderScope(child: ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context,child)=>const MyApp(),)));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: splashScreen(),
    );
  }
}
