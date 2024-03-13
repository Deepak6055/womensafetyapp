import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergencies/ambulanceemergency.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergencies/armyemergency.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergencies/friebridgeemergency.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergencies/policeemergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebridgeEmergency(),
          ArmyEmgergency(),
        ],
      ),
    );
  }
}