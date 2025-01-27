import 'package:flutter/material.dart';

Widget styledText(
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  String text,{double fontSize=20,FontWeight fontWeight = FontWeight.bold,Color }
){
  return Text(text,
  style: TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: Colors.black
  ),
  );
}