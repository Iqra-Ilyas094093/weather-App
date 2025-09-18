import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/network/api%20helpe/api_helper.dart';
import 'package:weather_app/utilities/key.dart';

class ApiServices{
  Future<void> getCurrentWeather(String location)async{
    final url = Uri.parse('${AppUrl.baseUrl}${AppUrl.currentEndpoint}?key=${API_KEY}&q=$location&aqi=no');
    final response = await http.get(url);
    print(response.body);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print(data);
    }else{
      print(response.statusCode);
      throw Exception('error in api connection');
    }
  }
}