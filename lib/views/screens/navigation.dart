import 'package:flutter/material.dart';
import 'package:weather_app/views/screens/all.dart';

import '../../utilities/colors.dart';
import 'home_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 1;
  final List<Widget> screens = [DetailsPage(), HomePage(), ForecasePage()];

  onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkPurple, AppColors.purple],
          ),
        ),
        // color: Colors.yellow,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/components/bottomBarRect.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/components/Subtract.png',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/icons/Map.png',
                        color: AppColors.primary,
                      ),

                    ),
                    IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.home,color: AppColors.purple,),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon:Image.asset(
                        'assets/icons/List.png',
                        color: AppColors.primary,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
