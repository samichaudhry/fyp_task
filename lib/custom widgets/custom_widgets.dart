import 'package:flutter/material.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

// Custom Button Widget
Widget customButton(buttonText, onPressedFunc, ctx, bWd, {int bHt = 6}) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(95)),
        color: Color(0xff009688)),
    height: responsiveHW(ctx, ht: bHt),
    width: responsiveHW(ctx, wd: bWd),
    child: TextButton(
      onPressed: onPressedFunc,
      child: Text(buttonText,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
    ),
  );
}

Widget customText(
    {txt,
    fsize = 16.0,
    clr,
    fweight = FontWeight.normal,
    txtalign,
    padding = 0.0}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Text(
      txt,
      textAlign: txtalign,
      style: TextStyle(fontSize: fsize, color: clr, fontWeight: fweight),
    ),
  );
}

Widget customTile({ontap, leading, title, subtitle, trailing, tilecolor}) {
  return ListTile(
    onTap: ontap,
    title: title,
    subtitle: subtitle,
    trailing: trailing,
    leading: leading,
    tileColor: tilecolor,
    // minLeadingWidth: 5.0,
    // horizontalTitleGap: 5.0,
  );
}

Future<void> dialog_func(_title, _content, noOntap, yesOntap) async {
  return Get.dialog(
    AlertDialog(
      title: _title,
      content: _content,
      actions: <Widget>[
        MaterialButton(
          onPressed: noOntap,
          child: const Text('No'),
        ),
        MaterialButton(
          onPressed: yesOntap,
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

Widget customFAB({ontap, text, icon, clr}) {
  return FloatingActionButton.extended(
    onPressed: ontap,
    label: text,
    icon: icon,
    backgroundColor: clr,
  );
}

// File Picker

Future filepicker({required filetype, allowedextensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: filetype,
    allowedExtensions: allowedextensions,
  );
  if (result != null) {
    return result.files.single.path.toString();
  } else {
    return '';
  }
}


void rawsnackbar(txt,{duration = 3,icon }) {
  Get.rawSnackbar(
    // backgroundColor: Colors.teal,
    // message: e.message.toString(),
    messageText: Text(
      txt,
      style: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
        // color: Colors.white,
      ),
    ),
    duration: Duration(seconds: duration),
    icon: icon,
  );
}

Future<void> customdialogcircularprogressindicator(txt) async {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        // title: _title,
        title: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  txt,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    // color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}