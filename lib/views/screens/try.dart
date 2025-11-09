import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController searchController = TextEditingController();

  String _getWeekday(DateTime date) {
    final weekdays = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];
    return weekdays[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final weatherVm = Provider.of<CurrentWeatherProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              _buildHeader(weatherVm),

              searchController.text.isEmpty?SizedBox():weatherVm.isLoading?Center(child: CircularProgressIndicator()):Column(
                children: [

                  // Current Weather Section
                  _buildCurrentWeather(weatherVm.weatherDetails!),
                  // Hourly Forecast
                  _buildHourlyForecast(weatherVm.weatherDetails!),

                  // 7-Day Forecast
                  _buildDailyForecast(weatherVm.weatherDetails!),

                  // Weather Details
                  _buildWeatherDetails(weatherVm.weatherDetails!['current']['feelslike_c'].toString(),weatherVm.weatherDetails!['current']['wind_mph'].toString(),weatherVm.weatherDetails!['current']['humidity'].toString(),weatherVm.weatherDetails!['current']['uv'].toString(),weatherVm.weatherDetails!['current']['vis_km'].toString(),weatherVm.weatherDetails!['forecast']['forecastday'][0]['astro']['sunrise'].toString()),

                  // Add some bottom padding for better scrolling
                  const SizedBox(height: 20),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  // ... rest of your methods remain exactly the same ...
  Widget _buildHeader(CurrentWeatherProvider weather) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12,),
              Text(
                'Manage Locations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFF2F2F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),

            ],
          ),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: searchController,
              onSubmitted: (value){
                weather.getWeatherDetails(value);
                setState(() {

                });
              },
              decoration: InputDecoration(
                hintText: 'Search for a city...',
                hintStyle: TextStyle(color: const Color(0xFF8892B0)),
                prefixIcon: Icon(Icons.search, color: const Color(0xFF8892B0)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              style: TextStyle(color: const Color(0xFFE6F1FF)),
            ),
          ),



        ],
      ),
    );
  }

  Widget _buildCurrentWeather(Map<String,dynamic> weather) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                weather['location']['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE6F1FF),
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),

          SizedBox(
              height:120,
              child: Image.network('https:${weather['current']['condition']['icon']}',fit: BoxFit.cover,)),
          const SizedBox(height: 8),
          Text(
            '${weather['current']['temp_c'].toString()}°',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE6F1FF),
              fontFamily: 'Manrope',
            ),
          ),
          Text(
            weather['current']['condition']['text'].toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFE6F1FF),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "H:${weather['forecast']['forecastday'][0]['day']['maxtemp_c']}° L:${weather['forecast']['forecastday'][0]['day']['mintemp_c']}°",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF8892B0),
            ),
          ),
        ],
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