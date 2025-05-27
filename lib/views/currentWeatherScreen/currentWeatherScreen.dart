import 'package:flutter/material.dart';

class currentWeatherScreen extends StatefulWidget {
  const currentWeatherScreen({super.key});

  @override
  State<currentWeatherScreen> createState() => _currentWeatherScreenState();
}

class _currentWeatherScreenState extends State<currentWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    width: width*0.10,
                    height: height*0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(onPressed: (){}, icon: Icons.),
                  )
                ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}
