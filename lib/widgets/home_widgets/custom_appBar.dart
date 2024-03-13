import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({super.key});
  Function? onTap;
  int? quoteIndex;
  CustomAppBar({this.onTap,this.quoteIndex}) : super();
  @override
  Widget build(BuildContext context) {
    return GestureDetector( //clickable widgets
      onTap: () {
        onTap!();
      },
      child: Container(
        child: Text(sweetSayings[quoteIndex!],
        style: TextStyle(fontSize: 22,)
      ),
    ),
    );
  }
}
