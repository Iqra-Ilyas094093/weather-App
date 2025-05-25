


import 'dart:core';

class Urls{
  static String API_KEY = "6c1156a454f14da08db210130252005";
  static String BASE_URL = 'https://api.weatherapi.com/v1';
  static String getWeatherUrl(String location){
    return '$BASE_URL/current.json?key=${API_KEY}&q=${location}';
  }
  static String getWeatherbylatlong(String latitude,String longitude){
    return "$BASE_URL/current.json?key=${API_KEY}&q=$latitude,$longitude";
  }
  static String getWeatherForecast(String location,int days){
    return '$BASE_URL/forecast.json?key=${API_KEY}&q=$location&days=$days';
  }
  static String searchLocation(String query){
    return '$BASE_URL/search.json?key=${API_KEY}&q=$query';
  }
  static String getHistoryData(String location,String date){
    return '$BASE_URL/history.json?key=${API_KEY}&q=$location&dt=$date';
  }
  static String getWeatherAlerts(String location){
    return '$BASE_URL/alerts.json?key=${API_KEY}&q=$location';
  }
  static String getMarineData(String location,String date){
    return '$BASE_URL/marine.json?key=${API_KEY}&q=$location&dt=$date';
  }
  static String getAstronomyData(String location,String date){
    return '$BASE_URL/astronomy.json?key=${API_KEY}&q=$location&dt=$date';
  }
}