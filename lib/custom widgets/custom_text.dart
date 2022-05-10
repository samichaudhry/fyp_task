
import 'package:flutter/material.dart';



Widget customText({txt,  fsize = 16.0,  clr = Colors.black, fweight = FontWeight.normal}) {
  return Text(txt, style: TextStyle(
    fontSize: fsize,
    color: clr,
    fontWeight: fweight
  ),);
}