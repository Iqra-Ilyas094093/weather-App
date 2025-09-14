import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final Size size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Weather App',
        debugShowCheckedModeBanner: false,
        // themeMode: themeMode,
        theme: ThemeData(
          fontFamily: 'SFProDisplay',
        ),
        // darkTheme: darkTheme,
        home: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height>932? 932:size.height,
                maxWidth: size.width>400?400:size.width,
              ),
              child: Builder(
                builder: (context) {
                  final mq = MediaQuery.of(context);
                  return MediaQuery(
                      data: mq.copyWith(
                        size: Size(size.width>400?400:size.width,size.height>932? 932:size.height),
                        devicePixelRatio: mq.devicePixelRatio,
                      ),
                      child: Navigation());
                }
              )),
        )
      ),
    );
  }
}
