import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customtoast(toastText) {
  Fluttertoast.showToast(
    // webBgColor: Colors.teal.withOpacity(0.75),
    msg: toastText,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.teal.withOpacity(0.75),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
