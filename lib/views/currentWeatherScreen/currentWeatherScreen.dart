import 'package:flutter/material.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF00A9FE), Color(0xFF005B87)],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 35,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.grid_view,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Minsk',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: height * 0.035,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white70, width: 1.0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Updating...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: height * 0.28,
                    width: width * 0.5,
                    child: Image.asset('assets/images/cloud_sun.png')),
                Text('21°',style: TextStyle(color: Colors.white,fontSize: 55,fontWeight: FontWeight.bold),),
                Text('Thunderstorm',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                Text('Monday, 26 May',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                  child: Divider(color: Color(0xFF005B87)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      infoTile(Icons.air, '13 km/h', 'Wind'),
                      infoTile(Icons.water_drop, '24%', 'Humidity'),
                      infoTile(Icons.opacity, '86%', 'Chance of Rain'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                Text('7 days',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              ],
            ),
          ),
          Container(
            height: height * 0.13,
            width: width * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 1.0,
                color: Colors.white70,
              ),
            ),
            child: Column(
              children: [
                Text('21°'),
                SizedBox(
                    height: 30,
                    child: Image.asset('assets/images/moon.png',)),
                Text('11:00')
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget infoTile(IconData icon, String temp,String type){
    return Column(
      children: [
        Icon(icon),
        Text(temp,style: TextStyle(color: Colors.white),),
        Text(type,style: TextStyle(color: Colors.white),),
      ],
    );
  }
}
