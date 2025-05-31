import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/model/weather_data_model/weather_data_model.dart';
import 'package:weather_app/network/api%20helpe/api_helper.dart';
import 'package:weather_app/utilities/text/textUtils.dart';
import 'package:weather_app/views/currentWeatherScreen/currentWeatherScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<weatherdata> _currentWeather;
  String currentLocation = 'punjab';
  PermissionStatus? locationPermission;
  TextEditingController weatherController = TextEditingController();

  Future<void> _checkPermission() async {
    locationPermission = await Permission.location.request();
    if (locationPermission!.isGranted) {
      await _getCurrentLocation();
    } else if (locationPermission!.isDenied) {
      locationPermission = await Permission.location.request();
    } else if (locationPermission!.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission is permanently denied'),
          action: SnackBarAction(
            label: 'Permission',
            onPressed: () async {
              await openAppSettings();
            },
          ),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placeMark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placeMark[0];
      String location = '${place.locality}';
      currentLocation = location;
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to get location')));
    }
  }

  @override
  void initState() {
    super.initState();
    _currentWeather = ApiHelper.fetchWeatherData(location: currentLocation);
    _checkPermission(); // optionally trigger location permission here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.red),
                Text(currentLocation),
              ],
            ),
            Text('Good Morning'),
          ],
        ),
        actions: [Icon(Icons.search, color: Colors.blue)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              controller: weatherController,
              decoration: InputDecoration(hintText: 'Search Weather'),
            ),
            _currentWeather == null
                ? Center(child: CircularProgressIndicator())
                : FutureBuilder(
                  future: _currentWeather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Error fetching data from server.'),
                      );
                    }
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Column();
                    }
                    return SizedBox();
                  },
                ),
          ],
        ),
      ),
    );
  }
}
