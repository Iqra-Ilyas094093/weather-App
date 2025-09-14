import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utilities/colors.dart';

class HomePage extends StatelessWidget {
  ScrollController scrollController = ScrollController();
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 0.95,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.lightPurple,AppColors.blackishPurple])
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Montreal',style: TextStyle(fontSize: 30,color: Colors.white,height: 1),),
            Text('19',
              style: TextStyle(fontSize: 60, color: Colors.white, height: 1),),
            Text('Mostly clear',
              style: TextStyle(fontSize: 20, color: Colors.white, height: 1),),
            Text('H:24, L:24',
              style: TextStyle(fontSize: 20, color: Colors.white),),
            Container(
              // color: Colors.yellowAccent,
                width: 160,
                height: 100,
                child: Image.asset(
                  'assets/components/SunCloudRain.png', scale: 0.7,)),
         SizedBox(height: 8,),
         Container(
                  height: size.height * 0.3,
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
                        height: 50.h,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 7.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.solidDarkPurple,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              Text('Hourly Forecast',style: TextStyle(color: AppColors.secondary,fontSize: 12,fontWeight: FontWeight.bold),),
                              Text('Weekly Forecast',style: TextStyle(color: Colors.grey,fontSize:12),),
                            ],),
                            SizedBox(height: 5.h,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                height: 2.h,
                                width: size.width/2,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.mouse,
                              PointerDeviceKind.trackpad,
                              PointerDeviceKind.touch
                            }
                          ),
                          child: ListView.builder(
                            controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
                              child: Container(
                                width: 50,
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
                                      Text('12 AM',style: TextStyle(color: AppColors.primary,fontSize: 10.spMin),),
                                      Image.asset('assets/components/moonCloud.png'),
                                      Text('12',style: TextStyle(color: AppColors.primary,fontSize: 10.spMin),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
            SizedBox(height: 20,),


          ],
        ),
      ),
      // backgroundColor: Colors.lightGreenAccent,
      // body: Stack(
      //   children: [
      //     Positioned.fill(child: Image.network('https://images.stockcake.com/public/a/c/6/ac6e7d92-9e4c-4038-89f3-ed22e65608a2_large/starry-night-sky-stockcake.jpg',fit: BoxFit.cover,)),
      //     Positioned(
      //       top: 10,
      //       child: Container(
      //         height: 300.h,
      //         width: size.width,
      //         // color: Colors.grey,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Text('Montreal',style: TextStyle(fontSize: 30,color: Colors.white,height: 1),),
      //             Text('19',style: TextStyle(fontSize: 60,color: Colors.white,height: 1),),
      //             Text('Mostly clear',style: TextStyle(fontSize: 20,color: Colors.white,height: 1),),
      //             Text('H:24, L:24',style: TextStyle(fontSize: 20,color: Colors.white),),
      //             Container(
      //                 // color: Colors.yellowAccent,
      //                 width: 160,
      //                 height: 100,
      //                 child: Image.asset('assets/components/SunCloudRain.png',scale: 0.7,)),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 40,
      //       child: Container(
      //         height: 280.h,
      //         width: size.width,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      //           gradient: LinearGradient(colors: [
      //             AppColors.darkPurple,
      //             AppColors.purple,
      //           ])
      //         ),
      //         child: Column(
      //           children: [
      //             Container(
      //               height: 50.h,
      //               width: size.width,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      //                   gradient: LinearGradient(
      //                       begin: Alignment.topCenter,
      //                       end: Alignment.bottomCenter,
      //                       colors: [
      //                         AppColors.purple,
      //                     AppColors.darkPurple,
      //                   ])
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Center(
      //                     child: Container(
      //                       height: 7.h,
      //                       width: 20.w,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                         color: AppColors.solidDarkPurple,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height: 5.h,),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                     Text('Hourly Forecast',style: TextStyle(color: AppColors.secondary,fontSize: 6.sp,fontWeight: FontWeight.bold),),
      //                     Text('Weekly Forecast',style: TextStyle(color: Colors.grey,fontSize: 6.sp),),
      //                   ],),
      //                   SizedBox(height: 5.h,),
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //                     child: Container(
      //                       height: 2.h,
      //                       width: size.width/2,
      //                       color: Colors.white,
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Expanded(
      //               child: ListView.builder(
      //                   scrollDirection: Axis.horizontal,
      //                   itemCount: 10,
      //                   shrinkWrap: true,
      //                   itemBuilder: (context,index){
      //                 return Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 6).w.h,
      //                   child: Container(
      //                     width: 20.w,
      //                     decoration: BoxDecoration(
      //                       border: Border.all(color: AppColors.purple.withValues(alpha: 0.9)),
      //                       gradient: LinearGradient(colors: [AppColors.darkPurple,AppColors.purple]),
      //                       borderRadius: BorderRadius.circular(40),
      //                     ),
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(vertical: 8.0,),
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Text('12 AM',style: TextStyle(color: AppColors.primary,fontSize: 10.spMin),),
      //                           Image.asset('assets/components/moonCloud.png'),
      //                           Text('12',style: TextStyle(color: AppColors.primary,fontSize: 10.spMin),),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               }),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
