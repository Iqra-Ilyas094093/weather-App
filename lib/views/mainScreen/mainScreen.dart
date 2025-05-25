import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_data_model/weather_data_model.dart';
import 'package:weather_app/network/api%20helpe/api_helper.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late Future<weatherdata> _currentWeather;
  String location = 'punjab';
  @override
  void initState() {
    _currentWeather = ApiHelper.fetchWeatherData(location: location);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(future: _currentWeather, builder: (context,snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            return SizedBox(
              child: Text(snapshot.data!.current!.dewpointC.toString(),style: TextStyle(color: Colors.white),),
            );
          }
          return SizedBox();
        }),
      ),
    );
  }
}
