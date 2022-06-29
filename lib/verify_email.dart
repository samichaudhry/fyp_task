import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_task/custom%20widgets/custom_toast.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
// import 'package:fyp_task/custom%20widgets/customdialog.dart';
import 'package:fyp_task/login_page.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:get/get.dart';

class verifyemail extends StatefulWidget {
  const verifyemail({Key? key}) : super(key: key);

  @override
  _verifyemailState createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel();
      Get.to(
        () => const SubjectsPage(),
      );
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.teal,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Verify Your email',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              // color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Text(
                  'A verification link has been sent to your email. please verify your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    // color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            MaterialButton(
              onPressed: () {
                customdialogcircularprogressindicator('Sending... ');
                FirebaseAuth.instance.currentUser
                    ?.sendEmailVerification()
                    .then((value) {
                  Navigator.pop(context);
                  customtoast('verification link sent.');
                });
              },
              color: Colors.teal,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              shape: const StadiumBorder(),
              child: const Text(
                'Resend Link',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  // color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            TextButton(
              onPressed: () {
                customdialogcircularprogressindicator('Loggingout... ');
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pop(context);
                  Get.to(
                    () => const LoginPage(),
                  );
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const StadiumBorder(),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
                    MediaQuery.of(context).size.height * 0.05),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
