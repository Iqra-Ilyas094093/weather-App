import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<CurrentWeatherProvider>(context,listen: false).getWeatherDetails('france');
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
                          'H:${weatherVm.weatherDetails!['forecast']['forecastday'][0]['day']['maxtemp_c']}° L:62°',
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
                      _buildHourlyForecast(),
                      const SizedBox(height: 24),

                      // Daily Forecast
                      _buildDailyForecast(),
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

  Widget _buildHourlyForecast() {
    final hourlyData = [
      {'time': 'Now', 'icon': Icons.wb_sunny, 'temp': '72°', 'isActive': true},
      {
        'time': '3 PM',
        'icon': Icons.wb_cloudy,
        'temp': '74°',
        'isActive': false,
      },
      {
        'time': '4 PM',
        'icon': Icons.wb_cloudy,
        'temp': '73°',
        'isActive': false,
      },
      {'time': '5 PM', 'icon': Icons.cloud, 'temp': '71°', 'isActive': false},
      {'time': '6 PM', 'icon': Icons.cloud, 'temp': '68°', 'isActive': false},
      {
        'time': '7 PM',
        'icon': Icons.nightlight_round,
        'temp': '66°',
        'isActive': false,
      },
    ];

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
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: hourlyData.length,
            itemBuilder: (context, index) {
              final item = hourlyData[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color:
                            item['isActive'] as bool
                                ? const Color(0xFF64FFDA).withOpacity(0.2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['time']!.toString(),
                            style: TextStyle(
                              color:
                                  item['isActive'] as bool
                                      ? const Color(0xFF64FFDA)
                                      : const Color(0xFF8892B0),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Manrope',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            item['icon'] as IconData,
                            color:
                                item['isActive'] as bool
                                    ? const Color(0xFF64FFDA)
                                    : const Color(0xFFE6F1FF),
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['temp']!.toString(),
                            style: TextStyle(
                              color:
                                  item['isActive'] as bool
                                      ? const Color(0xFF64FFDA)
                                      : const Color(0xFFE6F1FF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
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

  Widget _buildDailyForecast() {
    final dailyData = [
      {
        'day': 'Today',
        'icon': Icons.wb_sunny,
        'temp': 'H:75° L:62°',
      },
      {
        'day': 'Tuesday',
        'icon': Icons.wb_cloudy,
        'temp': 'H:72° L:60°',
      },
      {
        'day': 'Wednesday',
        'icon': Icons.cloud,
        'temp': 'H:70° L:58°',
      },
      {
        'day': 'Thursday',
        'icon': Icons.beach_access,
        'temp': 'H:68° L:55°',
      },
      {
        'day': 'Friday',
        'icon': Icons.wb_sunny,
        'temp': 'H:74° L:61°',
      },
    ];
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
            children:
                dailyData
                    .map(
                      (day) => Padding(
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
                                  flex: 1,
                                  child: Text(
                                    day['day']!.toString(),
                                    style: TextStyle(
                                      color: const Color(0xFFE6F1FF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ),
                                Icon(
                                  day['icon'] as IconData,
                                  size: 24,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    day['temp']!.toString(),
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
                      ),
                    )
                    .toList(),
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
