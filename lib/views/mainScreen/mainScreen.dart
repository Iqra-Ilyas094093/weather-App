import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/model/weather_data_model/weather_data_model.dart';
import 'package:weather_app/network/api%20helpe/api_helper.dart';
import 'package:weather_app/views/currentWeatherScreen/currentWeatherScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late Future<weatherdata> _currentWeather;
  String currentLocation = 'punjab';
  PermissionStatus? locationPermission;

  Future<void> _checkPermission() async {
    locationPermission = await Permission.location.request();
    if (locationPermission!.isGranted) {
      await _getCurrentLocation();
    } else if (locationPermission!.isDenied) {
      locationPermission = await Permission.location.request();
    } else if (locationPermission!.isDenied) {
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
      setState(() {
        
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Field to get location')));
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    _currentWeather = ApiHelper.fetchWeatherData(location: currentLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _currentWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error Fetching data from server .');
          }
          if (snapshot.hasData) {
            print(snapshot.data);
            return currentWeatherScreen();
          }
          return SizedBox();
        },
      ),
    );
  }
}
