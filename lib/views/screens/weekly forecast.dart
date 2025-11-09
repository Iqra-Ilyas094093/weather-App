import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';
import 'package:intl/intl.dart';

class SevenDayForecastPage extends StatefulWidget {
  final String location;
  const SevenDayForecastPage({super.key, required this.location});

  @override
  State<SevenDayForecastPage> createState() => _SevenDayForecastPageState();
}

class _SevenDayForecastPageState extends State<SevenDayForecastPage> {
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
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top App Bar
              _buildTopAppBar(),

              // Forecast List
              _buildForecastList(weatherVm.weatherDetails!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '7-Day Forecast',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
              letterSpacing: -0.015,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastList(Map<String,dynamic> weatherDetails) {
    final forecastDays = weatherDetails['forecast']['forecastday'] as List;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: forecastDays.length,
      itemBuilder: (context, index) {
        final dayData = forecastDays[index];
        final date = DateTime.parse(dayData['date']);
        final formattedDay = DateFormat('EEEE').format(date); // e.g. Thursday
        final today = DateTime.now();
        print(forecastDays.length);

        final isToday = date.day == today.day &&
            date.month == today.month &&
            date.year == today.year;

        final conditionText = dayData['day']['condition']['text'];
        final iconUrl = "https:${dayData['day']['condition']['icon']}";
        final maxTemp = dayData['day']['maxtemp_c'].round();
        final minTemp = dayData['day']['mintemp_c'].round();

        return _buildForecastItem(
          day: isToday ? 'Today' : formattedDay,
          condition: conditionText,
          iconUrl: iconUrl, // 👈 we pass the actual image URL now
          temperature: '$maxTemp° / $minTemp°',
          isHighlighted: isToday,
        );
      },
    );
  }

  Widget _buildForecastItem({
    required String day,
    required String condition,
    required String iconUrl,
    required String temperature,
    required bool isHighlighted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isHighlighted
            ? const Color(0xFF137FEC).withOpacity(0.2)
            : const Color(0xFF64748B).withOpacity(0.1),
        border: isHighlighted
            ? Border.all(color: const Color(0xFF137FEC).withOpacity(0.5))
            : null,
      ),
      child: Row(
        children: [
          // Weather Icon
          Image.network(iconUrl,height: 32,width: 32,),
          const SizedBox(width: 16),

          // Day and Condition
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: isHighlighted ? Colors.white : const Color(0xFFE2E8F0),
                    fontSize: 16,
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  condition,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),

          // Temperature
          Text(
            temperature,
            style: TextStyle(
              color: isHighlighted ? Colors.white : const Color(0xFFE2E8F0),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }
}