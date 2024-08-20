import 'package:flutter/material.dart';

const ShadowColor = Color(0x95E9EBF0);
const white = Color(0xFFffffff);

class ButtonClickListener {
  void onButtonClick() {
    print("Default Button Clicked !!");
  }
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow
          ? [BoxShadow(color: ShadowColor, blurRadius: 10, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

Widget backIcon(var color, var icon, var iconColor, double paddingStart,
    double paddingEnd) {
  return Padding(
    padding: EdgeInsets.only(left: paddingStart, right: paddingEnd),
    child: Container(
        width: 35,
        height: 35,
        decoration: boxDecoration(
            bgColor: color, radius: 10, color: white, showShadow: true),
        child: Center(child: Icon(icon, color: iconColor))),
  );
}
Widget backImageIcon(var color, var icon, double paddingStart, double paddingEnd) {
  return Padding(
    padding: EdgeInsets.only(left: paddingStart, right: paddingEnd),
    child: Container(
        width: 35,
        height: 35,
        decoration: boxDecoration(
            bgColor: color, radius: 10, color: white, showShadow: false),
        child: Center(child: icon,)),
  );
}

