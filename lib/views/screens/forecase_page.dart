import 'package:flutter/material.dart';
import 'package:weather_app/utilities/colors.dart';

class ForecasePage extends StatelessWidget {
  const ForecasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.greyPurple,AppColors.blackishPurple])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Weekly Forecast',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              Divider(color: AppColors.secondary,thickness: 0.7,),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    itemBuilder: (context,index){
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,
                      width: 350,
                      // color: Colors.grey,
                      child: Stack(
                        children: [
                          Positioned(
                              bottom:0,
                              child: Image.asset('assets/components/Rectangle.png',alignment: Alignment.bottomCenter,fit: BoxFit.cover,)),
                          Positioned(
                              right: 10,
                              top: 0,
                              child: Image.asset('assets/components/SunCloudRain.png')),
                          Positioned(
                            left: 15,
                            bottom: 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('12',style: TextStyle(fontSize: 60,color: AppColors.primary,height: 1),),
                                Text('H:24 L:25',style: TextStyle(fontSize: 20,color: Colors.grey),),
                                Text('Montreal, canada',style: TextStyle(fontSize: 18,color: AppColors.primary),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
