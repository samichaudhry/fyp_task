import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_task/attendance_sheet.dart';
import 'package:fyp_task/class_attendence.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Sheet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const class_attendence(),
    );
  }
}
