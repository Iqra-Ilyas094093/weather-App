


import 'dart:core';

class Urls{
  static String API_KEY = "6c1156a454f14da08db210130252005";
  static String BASE_URL = 'https://api.weatherapi.com/v1/';
  static String getWeatherUrl(String location){
    return '$BASE_URL/current.json?key=${API_KEY}&q=${location}';
  }
}