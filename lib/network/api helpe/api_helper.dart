import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data_model/weather_data_model.dart';

import '../../utilities/constants/apiKey.dart';

class ApiHelper {
  static Future<Map<String, dynamic>> getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to load data. Status code = ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error during API call $e');
    }
  }

  static Future<weatherdata> fetchWeatherData(
      {String? location, String? latitude, String? longitude})async{
    String url;
    if(latitude!=null && longitude!=null){
      url = Urls.getWeatherbylatlong(latitude, longitude);
    }else if(location!=null){
     url = Urls.getWeatherUrl(location);
    }else{
      throw Exception('Either location or latitude,longitude must be provided');
    }
    final response = await getApi(url);
    return weatherdata.fromJson(response);
  }
}
