import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const String API_KEY = "6c1156a454f14da08db210130252005";
class WeatherApiService{
  final String _baseUrl = 'https://api.weatherapi.com/v1';
  Future<Map<String,dynamic>> getHourlyForecast(String location)async{
    final url = Uri.parse('$_baseUrl/forecast.json?key=$API_KEY&q=$location&days=7');
    final response = await http.get(url);
    if(response.statusCode!=200){
      throw Exception('Failed to load data : ${response.body}');
    }
    final data = jsonDecode(response.body);
    if(data.containsKey('error')){
      throw Exception(data['error']['message']??'Invalid location');
    }
    return data;
  }
  Future<List<Map<String,dynamic>>>getPastSevenDaysWeather(String location)async{
    final List<Map<String,dynamic>> pastWeather = [];
    final today = DateTime.now();
    for(int i = 1;i<=7;i++){
      final data = today.subtract(Duration(days: i));
      final formattedDate = DateFormat('yyyy-MM-dd').format(data);
      final url = Uri.parse('$_baseUrl/history.json&key=$API_KEY&location=$location&dt=$formattedDate');
      final response = await http.get(url);
      if(response.statusCode == 200){
        final data= jsonDecode(response.body);
        if(data['forecast']?['forecastday']!=null){
          pastWeather.add(data);
        }
        if(data.containskey('error')){
          throw Exception(data['error']['messages']??'Invalid location');
        }
      }
      else{
        debugPrint('failed to load data from api : ${response.body}');
      }
    }
    return pastWeather;
  }
}