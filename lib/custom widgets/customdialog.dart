import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> dialog_func(_title, _content, no_ontap, yes_ontap) async {
  return Get.dialog(
    AlertDialog(
      title: _title,
      content: _content,
      actions: <Widget>[
        MaterialButton(
          onPressed: no_ontap,
          child: Text('No'),
        ),
        MaterialButton(
          onPressed: yes_ontap,
          child: Text('Yes'),
        ),
      ],
    ),
  );
}

Future<void> customdialogcircularprogressindicator(txt) async {
  Get.dialog(
    //  WillPopScope(
    //    onWillPop: () async => false,
    //    child: 
       AlertDialog(
        // title: _title,
        title: Row(
          // mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
        Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
         ],
       ),
         ),
    //  ),
    // barrierDismissible: false,
  )
  ;
}

