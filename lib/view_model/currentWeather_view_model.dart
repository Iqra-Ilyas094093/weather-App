import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/repositories/api_services.dart';
import 'package:weather_app/utilities/key.dart';
import 'package:http/http.dart'as http;

class CurrentWeatherProvider extends ChangeNotifier{
  final TextEditingController searchController = TextEditingController();
  final ApiServices _apiServices = ApiServices();
  // Map<String,dynamic>? currentWeatherModel;
  Map<String,dynamic>? weatherDetails;
  String? error;
  bool isLoading = false;

  // Future<void> fetchAll(String location)async{
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     await Future.wait([
  //       getCurrentWeather(location),
  //       getWeatherDetails(location),
  //     ]);
  //   } catch (e) {
  //     print("❌ Error fetching weather data: $e");
  //   }
  //
  //   isLoading = false;
  // }

  // Future<void> getCurrentWeather(String location)async{
  //   try{
  //     final currentWeather = _apiServices.getCurrentWeather(location);
  //     currentWeatherModel = await currentWeather;
  //   }catch(e){
  //     error = e.toString();
  //     dev.log('${e.toString()}');
  //     throw Exception(error);
  //
  //   }
  // }
  Future<void> getWeatherDetails(String location)async{
    isLoading = true;
    notifyListeners();
    try{
      final weatherDetail = _apiServices.getWeatherDetails(location);
      weatherDetails = await weatherDetail;
    }catch(e){
      error = e.toString();
      dev.log('${e.toString()}');
      throw Exception(error);

    }
    isLoading = false;
    notifyListeners();
  }

}