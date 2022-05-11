import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_task/attendance_sheet.dart';
import 'package:fyp_task/login.dart';
import 'package:fyp_task/nav_menu.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Sheet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Login(),
    );
  }
}
