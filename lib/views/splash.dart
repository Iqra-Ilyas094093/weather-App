import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class splash extends StatelessWidget {
  const splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3E2D8F), Color(0xff9D52AC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // image: DecorationImage(
          //   // image: AssetImage('assets/images/purplegradientbackground.jpg'),
          //   // Your image path
          //   fit: BoxFit.cover, // Fills the whole screen
          // ),
        ),
        child: Column(
          children: [
            Container(
              height: 428.h,
              width: 428.w,
              child: Image.asset('assets/images/Group.png'),
            ),
            SizedBox(
              height: 154.h,
              width: 429.w,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Weather',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2.h,
                      ),
                    ),
                    Text(
                      'ForeCasts',
                      style: GoogleFonts.poppins(
                        color: Color(0xffDDB130),
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.5.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              height: 72.h,
              width: 304.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: Color(0xffDDB130),
              ),
              child: Center(
                child: Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
