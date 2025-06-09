import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/views/mainWeatherUtility.dart';

class mainScreen extends StatefulWidget {
  final Map<String, dynamic> currentValue;
  final String city;
  final String country;
  final List<dynamic> pastWeek;
  final List<dynamic> next7days;

  const mainScreen({
    super.key,
    required this.currentValue,
    required this.city,
    required this.pastWeek,
    required this.next7days,
    required this.country,
  });

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.w),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/purplegradientbackground.jpg'),
                // Your image path
                fit: BoxFit.cover, // Fills the whole screen
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      mainWeatherUtility(
                        currentValue: widget.currentValue,
                        city: widget.city,
                        pastWeek: widget.pastWeek,
                        next7days: widget.next7days,
                        country: widget.country,
                      ),
                      Image.network(
                        'https:${widget.currentValue['condition']?['icon'] ?? ''}',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Text('next 7 days forecast',)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
