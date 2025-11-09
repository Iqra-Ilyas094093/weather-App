import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';

class WeatherHomePage extends StatefulWidget {
  final String location;
  const WeatherHomePage({super.key, required this.location});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<CurrentWeatherProvider>(context,listen: false).getWeatherDetails(widget.location);
    });


  }

  @override
  Widget build(BuildContext context) {
    final weatherVm = Provider.of<CurrentWeatherProvider>(context);
    // final highest = weatherVm.weatherDetails!['forecast']['forecastday'][0]['day']['maxtemp_c'];
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SafeArea(
        child:
            weatherVm.isLoading
                ? Center(child: CircularProgressIndicator())
                : weatherVm.weatherDetails != null
                ? SingleChildScrollView(
                  child: Column(
                                children: [
                  // Top App Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Color(0xFF8892B0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            weatherVm.weatherDetails!['location']['name']
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE6F1FF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Color(0xFF8892B0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Hero Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height:120,
                            child: Image.network('https:${weatherVm.weatherDetails!['current']['condition']['icon']}',fit: BoxFit.cover,)),
                        const SizedBox(height: 8),
                        Text(
                          weatherVm.weatherDetails!['current']['temp_c'].toString(),
                          style: TextStyle(
                            color: const Color(0xFFE6F1FF),
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Manrope',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          weatherVm.weatherDetails!['current']['condition']['text'].toString(),
                          style: TextStyle(
                            color: const Color(0xFFE6F1FF),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Manrope',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'H:${weatherVm.weatherDetails!['forecast']['forecastday'][0]['day']['maxtemp_c']}° L:${weatherVm.weatherDetails!['forecast']['forecastday'][0]['day']['mintemp_c']}°',
                          style: TextStyle(
                            color: const Color(0xFF8892B0),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Column(
                    children: [
                      // Hourly Forecast
                      _buildHourlyForecast(weatherVm.weatherDetails!),
                      const SizedBox(height: 24),

                      // Daily Forecast
                      _buildDailyForecast(weatherVm.weatherDetails!),
                      const SizedBox(height: 16),

                      // Weather Details
                      _buildWeatherDetails(weatherVm.weatherDetails!['current']['feelslike_c'].toString(),weatherVm.weatherDetails!['current']['wind_mph'].toString(),weatherVm.weatherDetails!['current']['humidity'].toString(),weatherVm.weatherDetails!['current']['uv'].toString(),weatherVm.weatherDetails!['current']['vis_km'].toString(),weatherVm.weatherDetails!['forecast']['forecastday'][0]['astro']['sunrise'].toString()),
                      const SizedBox(
                        height: 80,
                      ), // Space for bottom navigation
                    ],
                  ),
                                ],
                              ),
                )
                : Center(child: Text('failed to load data'),),
      ),
    );
  }

  Widget _buildHourlyForecast(Map<String, dynamic> weatherDetails) {
    final hourlyList = weatherDetails['forecast']['forecastday'][0]['hour'];

    // Get the target location's current local time
    final localTimeString = weatherDetails['location']['localtime'];
    final localTime = DateTime.parse(localTimeString);
    final localHour = localTime.hour;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOURLY FORECAST',
          style: TextStyle(
            color: const Color(0xFF8892B0),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyList.length,
            itemBuilder: (context, index) {
              final hourlyItem = hourlyList[index];
              final hourDateTime = DateTime.parse(hourlyItem['time']);
              final isActive = hourDateTime.hour == localHour;

              final hourLabel = isActive
                  ? 'Now'
                  : '${hourDateTime.hour.toString().padLeft(2, '0')}:00';

              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF64FFDA).withOpacity(0.2)
                      : const Color(0xFF3B4759),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hourLabel,
                      style: TextStyle(
                        color: isActive
                            ? const Color(0xFF64FFDA)
                            : const Color(0xFF8892B0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Image.network(
                      'https:${hourlyItem['condition']['icon']}',
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${hourlyItem['temp_c']}°',
                      style: TextStyle(
                        color: isActive
                            ? const Color(0xFF64FFDA)
                            : const Color(0xFFE6F1FF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  String _getWeekday(DateTime date) {
    final weekdays = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];
    return weekdays[date.weekday % 7];
  }


  Widget _buildDailyForecast(Map<String, dynamic> weatherDetails) {
    final dailyList = weatherDetails['forecast']['forecastday'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '7-DAY FORECAST',
          style: TextStyle(
            color: const Color(0xFF8892B0),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: dailyList.map<Widget>((dayData) {
              final date = DateTime.parse(dayData['date']);
              final dayOfWeek = _getWeekday(date);
              final maxTemp = dayData['day']['maxtemp_c'].toString();
              final minTemp = dayData['day']['mintemp_c'].toString();
              final iconUrl = dayData['day']['condition']['icon'];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dayOfWeek,
                            style: TextStyle(
                              color: const Color(0xFFE6F1FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                        Image.network(
                          'https:$iconUrl',
                          width: 30,
                          height: 30,
                        ),
                        Expanded(
                          child: Text(
                            'H:$maxTemp° L:$minTemp°',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color(0xFFE6F1FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetails(String feelLike,String windSpeed,String Humidity,String Uv,String visibility,String sunrise) {
    final detailsData = [
      {'label': 'Feels Like', 'value': '$feelLike°'},
      {'label': 'Wind Speed', 'value': '$windSpeed mph'},
      {'label': 'Humidity', 'value': '$Humidity%'},
      {'label': 'UV Index', 'value': Uv},
      {'label': 'Visibility', 'value': '$visibility mi'},
      {'label': 'Sunrise', 'value': sunrise},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WEATHER DETAILS',
          style: TextStyle(
            color: const Color(0xFF8892B0),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final item = detailsData[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['label']!,
                      style: TextStyle(
                        color: const Color(0xFF8892B0),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['value']!,
                      style: TextStyle(
                        color: const Color(0xFFE6F1FF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

}
