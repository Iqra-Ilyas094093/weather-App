import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/network/api%20helpe/api_helper.dart';
import 'package:weather_app/view_model/theme_view_model/theme_provider.dart';
import 'package:weather_app/views/mainScreen/mainScreen.dart';
import 'package:weather_app/views/mainWeatherUtility.dart';

class weatherScreen extends ConsumerStatefulWidget {
  const weatherScreen({super.key});

  @override
  ConsumerState<weatherScreen> createState() => _weatherScreenState();
}

class _weatherScreenState extends ConsumerState<weatherScreen> {
  final _weatherService = WeatherApiService();
  String city = 'france';
  String country = '';
  Map<String, dynamic> currentValue = {};
  List<dynamic> hourly = [];
  List<dynamic> pastWeek = [];
  List<dynamic> next7days = [];
  bool isLoading = false;

  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    try {
      final forecast = await _weatherService.getHourlyForecast(city);
      final past = await _weatherService.getPastSevenDaysWeather(city);
      setState(() {
        currentValue = forecast['current'] ?? {};
        hourly = forecast['forecast']?['forecastday']?[0]?['hour'] ?? [];
        next7days = forecast['forecast']?['forecastday'] ?? [];
        pastWeek = past;
        city = forecast['location']?['name'] ?? city;
        country = forecast['location']?['country'] ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        currentValue = {};
        hourly = [];
        pastWeek = [];
        next7days = [];
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('city not found or invalid. Please enter a valid city'),
        ),
      );
    }
  }

  String formatTime(String timeString) {
    DateTime time = DateTime.parse(timeString);
    return DateFormat.j().format(time);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;
    String iconPath = currentValue['condition']?['icon'] ?? '';
    String imageUrl = iconPath.isNotEmpty ? 'https:$iconPath' : '';
    Widget imageWidgets =
    imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      height: 150.h,
      width: 150.w,
      fit: BoxFit.cover,
    )
        : SizedBox();
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          // Responsive padding
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h, // Responsive height
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      if (value
                          .trim()
                          .isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'city not found or invalid. Please enter a valid city',
                            ),
                          ),
                        );
                        return;
                      }
                      city = value.trim();
                      _fetchWeather();
                    },
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search your city',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .surface,
                        size: 20.sp,
                      ),
                      hintStyle: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary,
                        fontSize: 14.sp,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .surface,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.yellow.shade900 : Colors.white70,
                  size: 24.sp,
                ),
                onTap: notifier.toggleTheme,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ...[
                if (currentValue.isNotEmpty)
                  Column(
                    children: [
                      mainWeatherUtility(currentValue: currentValue,
                          city: city,
                          pastWeek: pastWeek,
                          next7days: next7days,
                          country: country),
                      imageWidgets,
                      Padding(
                        padding: EdgeInsets.all(15.h.w),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              tempIcons(
                                'https://cdn-icons-png.flaticon.com/512/4148/4148460.png',
                                'humidity',
                                'Humidity',
                                '%',
                              ),
                              tempIcons(
                                'https://www.iconsdb.com/icons/preview/caribbean-blue/wind-turbine-xxl.png',
                                'wind_kph',
                                'wind',
                                'kph',
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://cdn-icons-png.freepik.com/256/3446/3446836.png?semt=ais_incoming',
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                                  Text(
                                    '${hourly.isNotEmpty ? hourly.map((
                                        h) => h['temp_c']).reduce((a, b) =>
                                    a > b
                                        ? a
                                        : b) : 'N/A'}',
                                    style: TextStyle(
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Max Temp',
                                    style: TextStyle(
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          border: Border(
                            top: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                            ),
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Today Forecast',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => mainScreen(
                                              currentValue: currentValue,
                                              city: city,
                                              pastWeek: pastWeek,
                                              next7days: next7days,
                                              country: country)));
                                    },
                                    child: Text(
                                      'Weekly Forecast',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Theme
                                .of(context)
                                .colorScheme
                                .secondary),
                            SizedBox(height: 5.h),
                            SizedBox(
                              height: 150.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hourly.length,
                                itemBuilder: (context, index) {
                                  final hour = hourly[index];
                                  final now = DateTime.now();
                                  final hourTime = DateTime.parse(hour['time']);
                                  final isCurrentHour =
                                      now.hour == hourTime.hour &&
                                          now.day == hourTime.day;
                                  return Padding(
                                    padding: EdgeInsets.all(8.h.w),
                                    child: Container(
                                      height: 80.h,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                        isCurrentHour
                                            ? Colors.orange
                                            : Colors.black38,
                                        borderRadius: BorderRadius.circular(40.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            isCurrentHour
                                                ? 'Now'
                                                : formatTime(hour['time']),
                                            style: TextStyle(
                                              color:
                                              Theme
                                                  .of(
                                                context,
                                              )
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Image.network(
                                            'https:${hour['condition']?['icon']}',
                                            height: 40.h,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "${hour['temp_c']}°C",
                                            style: TextStyle(
                                              color:
                                              Theme
                                                  .of(
                                                context,
                                              )
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
          ],
        ),
      ),
    );
  }

  Widget tempIcons(String image, String temp, String name, String symbol) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(image, width: 30.w, height: 30.h),
        Text(
          '${currentValue['$temp']}$symbol',
          style: TextStyle(
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name,
          style: TextStyle(color: Theme
              .of(context)
              .colorScheme
              .secondary),
        ),
      ],
    );
  }
}
