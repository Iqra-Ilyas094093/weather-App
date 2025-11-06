import 'package:flutter/material.dart';

class ManageLocationsPage extends StatefulWidget {
  const ManageLocationsPage({super.key});

  @override
  State<ManageLocationsPage> createState() => _ManageLocationsPageState();
}

class _ManageLocationsPageState extends State<ManageLocationsPage> {
  bool _isCelsius = true;
  final TextEditingController _searchController = TextEditingController();

  final List<LocationItem> _locations = [
    LocationItem(
      name: 'Current Location',
      condition: 'Sunny, 72°',
      icon: Icons.my_location,
      backgroundColor: const Color(0xFF007AFF),
      iconColor: const Color(0xFF007AFF),
      isDeletable: false,
    ),
    LocationItem(
      name: 'New York',
      condition: 'Partly Cloudy, 68°',
      icon: Icons.cloud,
      backgroundColor: const Color(0xFF5856D6),
      iconColor: Colors.white,
      isDeletable: true,
    ),
    LocationItem(
      name: 'London',
      condition: 'Rain, 55°',
      icon: Icons.beach_access,
      backgroundColor: const Color(0xFF34C759),
      iconColor: Colors.white,
      isDeletable: true,
    ),
    LocationItem(
      name: 'Tokyo',
      condition: 'Clear, 81°',
      icon: Icons.wb_sunny,
      backgroundColor: const Color(0xFFFFD60A),
      iconColor: Colors.white,
      isDeletable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF121212).withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFF2F2F7),
                        size: 28,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Manage Locations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFF2F2F7),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: const Color(0xFF007AFF),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Color(0xFF8A8A8E),
                                size: 24,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                style: TextStyle(
                                  color: const Color(0xFFF2F2F7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Manrope',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search for a city or zip code',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF8A8A8E),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Manrope',
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Temperature Unit Toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildTemperatureToggle('°F', !_isCelsius),
                                _buildTemperatureToggle('°C', _isCelsius),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Saved Locations List
                    Column(
                      children: _locations.map((location) => _buildLocationItem(location)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureToggle(String unit, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCelsius = unit == '°C';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF007AFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: const Color(0xFF007AFF).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Text(
          unit,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF8A8A8E),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Manrope',
          ),
        ),
      ),
    );
  }

  Widget _buildLocationItem(LocationItem location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Drag handle
            Icon(
              Icons.drag_handle,
              color: const Color(0xFF8A8A8E),
              size: 28,
            ),
            const SizedBox(width: 16),

            // Weather icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: location.backgroundColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                location.icon,
                color: location.iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Location info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: TextStyle(
                      color: const Color(0xFFF2F2F7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location.condition,
                    style: TextStyle(
                      color: const Color(0xFF8A8A8E),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ),

            // Delete/Block icon
            IconButton(
              onPressed: location.isDeletable
                  ? () {
                setState(() {
                  _locations.remove(location);
                });
              }
                  : null,
              icon: Icon(
                location.isDeletable ? Icons.remove_circle : Icons.block,
                color: location.isDeletable
                    ? const Color(0xFFFF3B30)
                    : const Color(0xFF8A8A8E).withOpacity(0.5),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationItem {
  final String name;
  final String condition;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool isDeletable;

  LocationItem({
    required this.name,
    required this.condition,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.isDeletable,
  });
}