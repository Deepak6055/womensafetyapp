import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_widgets/live_safe/PoliceStationCard.dart';
import 'package:flutter_application_1/widgets/home_widgets/live_safe/hospitalCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});
  static Future<void> openMap(String location) async{
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try{
      await launchUrl(_url);
    }catch (e){
      Fluttertoast.showToast(msg:'Something Went Wrong!Call Emergency Number');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}