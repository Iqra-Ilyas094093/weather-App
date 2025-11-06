import 'package:flutter/material.dart';

class HourlyWeatherPage extends StatelessWidget {
  const HourlyWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top App Bar
              _buildTopAppBar(),
          
              // Location and Date
              _buildLocationDate(),
          
              // Temperature Chart
              _buildTemperatureChart(),
              SizedBox(height: 20,),
          
              // Hourly Forecast List
              _buildHourlyForecast(),
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
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFFF7FAFC), size: 24),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Color(0xFFF7FAFC), size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New York, NY',
            style: TextStyle(
              color: const Color(0xFFF7FAFC),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Today, Oct 26',
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

  Widget _buildTemperatureChart() {
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
                  '15°C',
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
                  '+2°',
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

  Widget _buildHourlyForecast() {
    final hourlyData = [
      {'time': '1 PM', 'icon': Icons.cloud, 'temp': '15°C', 'precip': '20%', 'isActive': false},
      {'time': '2 PM', 'icon': Icons.wb_sunny, 'temp': '16°C', 'precip': '15%', 'isActive': false},
      {'time': '3 PM', 'icon': Icons.wb_sunny, 'temp': '17°C', 'precip': '10%', 'isActive': true},
      {'time': '4 PM', 'icon': Icons.cloud, 'temp': '16°C', 'precip': '15%', 'isActive': false},
      {'time': '5 PM', 'icon': Icons.cloud_queue, 'temp': '14°C', 'precip': '25%', 'isActive': false},
      {'time': '6 PM', 'icon': Icons.beach_access, 'temp': '13°C', 'precip': '30%', 'isActive': false},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 180,
        child: ListView.builder(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: hourlyData.length,
          itemBuilder: (context, index) {
            final data = hourlyData[index];
            return _buildHourCard(
              time: data['time'] as String,
              icon: data['icon'] as IconData,
              temperature: data['temp'] as String,
              precipitation: data['precip'] as String,
              isActive: data['isActive'] as bool,
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