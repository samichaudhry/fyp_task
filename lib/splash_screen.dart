import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/login_page.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isonline = true;
  @override
  void initState() {
    super.initState();
    initTimer();
  }

//  @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

  Future<bool> CheckConnection() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      //  var connectivityResult = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print('connection available');
        return true;
      } else {
        print('connection unavailable');
        return false;
      }
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status error: $e');
      print('connection unavailable');
      return false;
    }
  }

  Future<void> initTimer() async {
    if (await CheckConnection()) {
      Timer(const Duration(seconds: 2), () async {
        if (FirebaseAuth.instance.currentUser == null) {
          // pehly != tha
          Get.to(
            () => const LoginPage(),
          );
          //   if (FirebaseAuth.instance.currentUser!.emailVerified) {
          //     FirebaseFirestore.instance
          //         .collection('users')
          //         .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          //         .get()
          //         .then((DocumentSnapshot ds) {
          //       if (ds.exists) {
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => const HomePage()));
          //       } else {
          //         Get.to(
          //           Editprofile(),
          //           arguments: [
          //             {
          //               'isedit': false,
          //               'appbartitle': 'Set profile',
          //               '_displayname': '',
          //               '_countryname': '',
          //               '_cityname': '',
          //               '_profilepic':
          //                   'https://banner2.cleanpng.com/20180702/juw/kisspng-australia-national-cricket-team-bowling-cricket-5b39ce04df1a32.1401674715305149489138.jpg',
          //             },
          //           ],
          //         );
          //       }
          //     });
          //   } else {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const verifyemail()));
          //   }
        } else {
          Get.to(() => const SubjectsPage());
        }
      });
    } else {
      //  Timer(const Duration(seconds: 4), () async{
      //  SystemNavigator.pop();
      //  });
      setState(() {
        isonline = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            WillPopScope(onWillPop: () async => false, child: customAlert()),
        barrierDismissible: false,
      );
      //  customAlert();
    }
  }

  Widget customAlert() {
    // SplashWidget().showSplashLogo();
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10.0),
      actionsPadding: const EdgeInsets.only(bottom: 10.0),
      title: Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        color: Colors.red[400],
        size: 70.0,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Text(
          'No internet available! Please\n reconnect and try again',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              // color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0),
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () async {
              SystemNavigator.pop();
            },
            child: const Text('ok'),
            style: TextButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                  MediaQuery.of(context).size.height * 0.06),
              maximumSize: Size(MediaQuery.of(context).size.width * 0.75,
                  MediaQuery.of(context).size.height * 0.06),
              primary: Colors.black,
              backgroundColor: Colors.grey[350],
              elevation: 2.0,
              textStyle: const TextStyle(
                  fontSize: 20, fontFamily: "Viga", color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        // color: Colors.white,
        width: widthSize,
        height: heightSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/splashLogo.png",
            //   width: widthSize * 30 / 100,
            //   height: heightSize * 15 / 100,
            // ),
            const Icon(
              FontAwesomeIcons.graduationCap,
              size: 50.0,
              color: Colors.teal,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              "TUB Attendance App",
              style: TextStyle(
                fontSize: heightSize * 3 / 100,
                color: Colors.teal,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: heightSize * 20 / 100,
            ),
            !isonline
                ? const Center()
                : const CircularProgressIndicator(
                    color: Colors.teal,
                    strokeWidth: 3.0,
                  ),
            SizedBox(
              height: heightSize * 3 / 100,
            ),
            !isonline
                ? const Center()
                : Text(
                    "Loading",
                    style: TextStyle(
                      fontSize: heightSize * 2 / 100,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
