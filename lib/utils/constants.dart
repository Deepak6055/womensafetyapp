import 'package:flutter/material.dart';

Color primaryColor = Color(
  0xfffc3b77,
);

void goto(BuildContext context, Widget nextScreen){
 Navigator.push(
  context,
MaterialPageRoute(
  builder: (context) => nextScreen,
  ));
}