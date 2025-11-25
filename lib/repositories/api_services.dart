import 'dart:convert';
import 'dart:developer' as dev;

import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/utilities/key.dart';
import 'package:http/http.dart'as http;

class ApiServices{

  Future<Map<String,dynamic>> getCurrentWeather(String location)async{
    final url = '${AppUrl.baseUrl}${AppUrl.currentEndpoint}${keys.key}&q=$location';
    print('current weather url = $url');
    final response = await http.get(Uri.parse(url));
    try{
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return data;
      }else{
        throw Exception(response.statusCode);
      }
    }catch(e,s){
      dev.log(response.statusCode.toString());
      dev.log('failed to load current weather api with error $e');
      print(s.toString());
      throw Exception(e.toString());
    }
  }
  Future<Map<String,dynamic>> getWeatherDetails(String location)async{
    final url = '${AppUrl.baseUrl}${AppUrl.forecastEndpoint}${keys.key}&q=$location&days=7';
    print('Url for weather details = $url');
    final response = await http.get(Uri.parse(url));
    try{
      dev.log(response.statusCode.toString());
      final data = jsonDecode(response.body);
      return data;

    }catch(e,s){
      dev.log(e.toString());
      print(response.statusCode.toString());
      print('failed to load the weather details with status code ${response.statusCode}');
      dev.log(s.toString());
      throw Exception('failed to load data for weather details');

    }
  }

}