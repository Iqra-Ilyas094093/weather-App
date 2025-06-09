import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class mainWeatherUtility extends StatelessWidget {
  final Map<String, dynamic> currentValue;
  final String city;
  final String country;
  final List<dynamic> pastWeek;
  final List<dynamic> next7days;

  const mainWeatherUtility({
    super.key,
    required this.currentValue,
    required this.city,
    required this.pastWeek,
    required this.next7days, required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$city${country.isNotEmpty ? ',$country' : ''}',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '${currentValue['temp_c']}°C',
          style: TextStyle(
            fontSize: 40.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${currentValue['condition']['text']}',
          style: TextStyle(
            fontSize: 22.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
