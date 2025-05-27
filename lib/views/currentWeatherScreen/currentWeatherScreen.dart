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
            height: height * 0.75,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.blue,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00A9FE),
                  Color(0xFF005B87),
                  // Color(0xFF61AEEB),
                  // Color(0xFF288EE2),
                  // Color(0xFF1E6BAA),
                  // Color(0xFF144771),
                  // Color(0xFF0A2439),
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 35),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.grid_view,size: 25,),
                      ),
                      Spacer(),
                      Text('Minsk',style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,size: 25,),),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.035,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(child: Text('Updating...',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
