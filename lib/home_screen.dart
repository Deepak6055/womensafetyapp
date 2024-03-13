import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/home_widgets/CustomCarouel.dart';
import 'package:flutter_application_1/widgets/home_widgets/custom_appBar.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergency.dart';
import 'package:flutter_application_1/widgets/home_widgets/live_safe.dart';
import 'package:flutter_application_1/widgets/home_widgets/safehome/SafeHome.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int qIndex = 2;

 getRandomQuote() {
  Random random = Random();
  setState(() {
   qIndex = random.nextInt(6); 
  });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 220, 220),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Women Safety",
                        style: 
                        TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      ),
                    ),
              CustomAppBar(
                quoteIndex: qIndex,
                onTap: getRandomQuote,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomCarouel(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Emergency",
                        style: 
                        TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Emergency(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Explore Live Safe",
                        style: 
                        TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    LiveSafe(),
                    SafeHome(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}