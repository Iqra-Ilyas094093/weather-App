import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';
import 'package:intl/intl.dart';

class HourlyWeatherPage extends StatefulWidget {
  final String location;
  const HourlyWeatherPage({super.key, required this.location});

  @override
  State<HourlyWeatherPage> createState() => _HourlyWeatherPageState();
}

class _HourlyWeatherPageState extends State<HourlyWeatherPage> {



  IconData _getWeatherIcon(String condition) {
    final lower = condition.toLowerCase();
    if (lower.contains('sun')) return Icons.wb_sunny;
    if (lower.contains('cloud')) return Icons.cloud;
    if (lower.contains('rain')) return Icons.beach_access;
    if (lower.contains('snow')) return Icons.ac_unit;
    return Icons.wb_cloudy;
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<CurrentWeatherProvider>(context,listen: false).getWeatherDetails(widget.location);
    });
    // TODO: implement initState
    super.initState();
  }

  String formatDate(String apiDate) {
    final dateTime = DateTime.parse(apiDate); // Parse the yyyy-MM-dd format
    final formatter = DateFormat('MMM d'); // Format to 'Nov 6'
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final weatherVm = Provider.of<CurrentWeatherProvider>(context);
    final date = weatherVm.weatherDetails!['forecast']['forecastday'][0]['date'].toString();
    final temp_c = weatherVm.weatherDetails!['current']['temp_c'];
    final feel_like = weatherVm.weatherDetails!['current']['feelslike_c'];
    final diff = feel_like - temp_c;
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
        child: weatherVm.isLoading?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Column(
            children: [
              // Top App Bar
              _buildTopAppBar(),

              // Location and Date
              _buildLocationDate(weatherVm.weatherDetails!['location']['name'].toString(),weatherVm.weatherDetails!['location']['country'].toString(),formatDate(date)),

              // Temperature Chart
              _buildTemperatureChart(temp_c.toString(),diff),
              SizedBox(height: 20,),

              // Hourly Forecast List
              _buildHourlyForecast(weatherVm.weatherDetails!),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFFF7FAFC), size: 24),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildLocationDate(String city,String country,String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$city, $country',
            style: TextStyle(
              color: const Color(0xFFF7FAFC),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Today, $date',
            style: TextStyle(
              color: const Color(0xFF92ADC9),
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureChart(String temp,double diff) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature Trend',
              style: TextStyle(
                color: const Color(0xFFF7FAFC),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '$temp°C',
                  style: TextStyle(
                    color: const Color(0xFFF7FAFC),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Hourly',
                  style: TextStyle(
                    color: const Color(0xFF92ADC9),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  diff > 0
                      ? '+${diff.round()}°'
                      : diff < 0
                      ? '${diff.round()}°'
                      : '',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Simplified chart representation
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: TemperatureChartPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyForecast(Map<String, dynamic> weatherDetails) {
    if (weatherDetails.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Extract hourly forecast from API
    final forecastHours = weatherDetails['forecast']['forecastday'][0]['hour'];

    // Extract location local time from API (accurate for that city)
    final localTimeString = weatherDetails['location']['localtime'];
    final localTime = DateTime.parse(localTimeString);
    final localHour = localTime.hour;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecastHours.length,
          itemBuilder: (context, index) {
            final hourData = forecastHours[index];

            // Parse hour time from API
            final forecastTime = DateTime.parse(hourData['time']);
            final forecastHour = forecastTime.hour;

            // Build each card dynamically
            return _buildHourCard(
              time: DateFormat('h a').format(forecastTime), // e.g. 3 PM
              icon: _getWeatherIcon(hourData['condition']['text']),
              temperature: '${hourData['temp_c']}°C',
              precipitation: '${hourData['chance_of_rain']}%',
              isActive: forecastHour == localHour, // highlight if same as local hour
            );
          },
        ),
      ),
    );
  }


  Widget _buildHourCard({
    required String time,
    required IconData icon,
    required String temperature,
    required String precipitation,
    required bool isActive,
  }) {
    return Container(
      width: 112,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? const Color(0xFF4FD1C5) : const Color(0xFF324D67),
          width: isActive ? 2 : 1,
        ),
        color: isActive
            ? const Color(0xFF4FD1C5).withOpacity(0.2)
            : const Color(0xFF192633),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              color: isActive ? const Color(0xFF4FD1C5) : const Color(0xFF92ADC9),
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 12),
          Icon(
            icon,
            color: isActive ? const Color(0xFF4FD1C5) : const Color(0xFFF7FAFC),
            size: 28,
          ),
          const SizedBox(height: 12),
          Text(
            temperature,
            style: TextStyle(
              color: const Color(0xFFF7FAFC),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            precipitation,
            style: TextStyle(
              color: const Color(0xFF92ADC9),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4FD1C5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF4FD1C5).withOpacity(0.3),
          const Color(0xFF4FD1C5).withOpacity(0.0),
        ],
      ).createShader(Rect.fromPoints(
        Offset(0, 0),
        Offset(size.width, size.height),
      ))
      ..style = PaintingStyle.fill;

    // Simplified chart path (you can make this more accurate)
    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(0, size.height * 0.73),
      Offset(size.width * 0.08, size.height * 0.14),
      Offset(size.width * 0.15, size.height * 0.27),
      Offset(size.width * 0.23, size.height * 0.62),
      Offset(size.width * 0.31, size.height * 0.22),
      Offset(size.width * 0.38, size.height * 0.67),
      Offset(size.width * 0.46, size.height * 0.41),
      Offset(size.width * 0.54, size.height * 0.41),
      Offset(size.width * 0.62, size.height * 0.81),
      Offset(size.width * 0.69, size.height * 0.99),
      Offset(size.width * 0.77, size.height * 0.01),
      Offset(size.width * 0.85, size.height * 0.54),
      Offset(size.width * 0.92, size.height * 0.86),
      Offset(size.width, size.height * 0.17),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
      fillPath.lineTo(points[i].dx, points[i].dy);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}