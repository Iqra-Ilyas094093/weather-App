import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/colors.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.lightPurple,AppColors.blackishPurple]),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            style: TextStyle(color: AppColors.primary),
                            controller: searchController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: Colors.grey.shade300,
                                size: 20,
                              ),
                              hintText: 'Enter location',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: AppColors.primary,
                              ),
                              contentPadding: EdgeInsets.only(left: 25, top: 3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.mic, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Container(
                  height: 420,
                  width: size.width,
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Text(
                        'Montreal',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        '19',
                        style: TextStyle(
                          fontSize: 75,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Mostly clear',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        'H:24, L:24',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Image.asset('assets/components/SunCloudRain.png', scale: 0.7),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.transparent,
                            ),
                            child: Icon(Icons.wind_power, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '95%',
                            style: TextStyle(
                              color: Colors.white,
                              height: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              color: Colors.white,
                              height: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
