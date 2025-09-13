import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utilities/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.lightGreenAccent,
      body: Stack(
        children: [
          Positioned.fill(child: Image.network('https://images.stockcake.com/public/a/c/6/ac6e7d92-9e4c-4038-89f3-ed22e65608a2_large/starry-night-sky-stockcake.jpg',fit: BoxFit.cover,)),
          Positioned(
            top: 80,
            child: Container(
              height: 450,
              width: size.width,
              // color: Colors.grey,
              child: Column(
                children: [
                  Text('Montreal',style: TextStyle(fontSize: 40,color: Colors.white,height: 1),),
                  Text('19',style: TextStyle(fontSize: 75,color: Colors.white,height: 1),),
                  Text('Mostly clear',style: TextStyle(fontSize: 25,color: Colors.white,height: 1),),
                  Text('H:24, L:24',style: TextStyle(fontSize: 25,color: Colors.white),),
                  Image.asset('assets/components/SunCloudRain.png',scale: 0.7,),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            child: Container(
              height: 280,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  AppColors.darkPurple,
                  AppColors.purple,
                ])
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.purple,
                          AppColors.darkPurple,
                        ])
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 7,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.solidDarkPurple,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Text('Hourly Forecast',style: TextStyle(color: AppColors.secondary,fontSize: 18,fontWeight: FontWeight.bold),),
                          Text('Weekly Forecast',style: TextStyle(color: Colors.grey,fontSize: 18),),
                        ],),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 2,
                            width: size.width/2,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.purple.withValues(alpha: 0.9)),
                            gradient: LinearGradient(colors: [AppColors.darkPurple,AppColors.purple]),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('12 AM',style: TextStyle(color: AppColors.primary,fontSize: 20),),
                                Image.asset('assets/components/moonCloud.png'),
                                Text('12',style: TextStyle(color: AppColors.primary,fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
