import 'package:flutter/material.dart';

class SevenDayForecastPage extends StatelessWidget {
  const SevenDayForecastPage({super.key});

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

              // Forecast List
              _buildForecastList(),
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
            icon: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Icon(
                Icons.menu,
                color: Color(0xFFCBD5E1),
                size: 24,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              '7-Day Forecast',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Manrope',
                letterSpacing: -0.015,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFFCBD5E1),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastList() {
    final forecastData = [
      {
        'day': 'Today',
        'condition': 'Partly Cloudy',
        'icon': Icons.cloud,
        'iconColor': Colors.yellow,
        'temp': '75° / 58°',
        'isHighlighted': true,
      },
      {
        'day': 'Tomorrow',
        'condition': 'Sunny',
        'icon': Icons.wb_sunny,
        'iconColor': Colors.yellow,
        'temp': '82° / 65°',
        'isHighlighted': false,
      },
      {
        'day': 'Wednesday',
        'condition': 'Showers',
        'icon': Icons.beach_access,
        'iconColor': Colors.blue,
        'temp': '72° / 60°',
        'isHighlighted': false,
      },
      {
        'day': 'Thursday',
        'condition': 'Thunderstorms',
        'icon': Icons.thunderstorm,
        'iconColor': Colors.amber,
        'temp': '70° / 55°',
        'isHighlighted': false,
      },
      {
        'day': 'Friday',
        'condition': 'Cloudy',
        'icon': Icons.cloud_queue,
        'iconColor': Colors.grey,
        'temp': '68° / 52°',
        'isHighlighted': false,
      },
      {
        'day': 'Saturday',
        'condition': 'Sunny',
        'icon': Icons.wb_sunny,
        'iconColor': Colors.yellow,
        'temp': '77° / 60°',
        'isHighlighted': false,
      },
      {
        'day': 'Sunday',
        'condition': 'Light Rain',
        'icon': Icons.grain,
        'iconColor': Colors.blue,
        'temp': '74° / 63°',
        'isHighlighted': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: forecastData.length,
      itemBuilder: (context, index) {
        final data = forecastData[index];
        return _buildForecastItem(
          day: data['day'] as String,
          condition: data['condition'] as String,
          icon: data['icon'] as IconData,
          iconColor: data['iconColor'] as Color,
          temperature: data['temp'] as String,
          isHighlighted: data['isHighlighted'] as bool,
        );
      },
    );
  }

  Widget _buildForecastItem({
    required String day,
    required String condition,
    required IconData icon,
    required Color iconColor,
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
          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
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