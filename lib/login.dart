import 'package:flutter/material.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.teal,
          onPressed: () {
            
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
