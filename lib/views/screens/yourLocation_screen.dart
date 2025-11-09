import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/currentWeather_view_model.dart';
import 'package:weather_app/views/screens/navigation.dart';

class YourlocationScreen extends StatelessWidget {
  YourlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<CurrentWeatherProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFF0A192F),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Text(
              'Enter Your Location',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF8A8A8E),
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted:(value){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Navigation()));
                      } ,
                      controller:weather.searchController ,
                      style: TextStyle(
                        color: const Color(0xFFF2F2F7),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Manrope',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search for a city or zip code',
                        hintStyle: TextStyle(
                          color: const Color(0xFF8A8A8E),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Manrope',
                        ),

                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
