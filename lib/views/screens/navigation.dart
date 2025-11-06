import 'package:flutter/material.dart';
import 'package:weather_app/views/screens/hourly_weather_page.dart';
import 'package:weather_app/views/screens/location_page.dart';
import 'package:weather_app/views/screens/weekly%20forecast.dart';
import 'home_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;
  final List<Widget> screens = [WeatherHomePage(), HourlyWeatherPage(), SevenDayForecastPage(),ManageLocationsPage()];

  onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar:  Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A192F).withOpacity(0.8),
          border: const Border(
            top: BorderSide(color: Colors.white10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.thermostat,
                label: 'Current',
                isActive: true,
                index: 0
              ),
              _buildNavItem(
                icon: Icons.map,
                label: 'Map',
                isActive: false,
                index: 1
              ),
              _buildNavItem(
                icon: Icons.settings,
                label: 'Settings',
                isActive: false,
                index: 2
              ),_buildNavItem(
                icon: Icons.settings,
                label: 'Settings',
                isActive: false,
                index: 3
              ),
            ],
          ),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required int index,
  }) {
    return GestureDetector(
      onTap: (){
        onTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? const Color(0xFF64FFDA) : const Color(0xFF8892B0),
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? const Color(0xFF64FFDA) : const Color(0xFF8892B0),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }
}
