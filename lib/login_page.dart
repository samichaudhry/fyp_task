import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fyp_task/add_teacher.dart';
import 'package:fyp_task/custom%20widgets/custom_toast.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/forget_password.dart';
import 'package:fyp_task/utils.dart';
import 'package:fyp_task/wavy_design.dart';
import 'package:get/get.dart';
import 'package:fyp_task/subjects_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passwordVisible = true;
  bool isauthenticating = false;
  // Visibility of password
  void _passwordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<dynamic> _loginFunc(useremail, userpassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: useremail.toString(), password: userpassword.toString());
      await FirebaseFirestore.instance
          .collection('teachers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((DocumentSnapshot user) {
        if (user.exists) {
          if (!user['isTeacher']) {
            customtoast('Invalid teacher credentials');
            FirebaseAuth.instance.signOut();
          } else {
            if (user['status'] == 'Approved') {
              Get.to(
                () => const SubjectsPage(),
              );

              customtoast('Login Successful');
            } else if (user['status'] == 'Pending') {
              customtoast('Request pending\nlogin not allowed.');
              FirebaseAuth.instance.signOut();
            } else {
              customtoast('Request declined. login not allowed.');
              FirebaseAuth.instance.signOut();
            }
          }
          setState(() {
            isauthenticating = false;
          });
        } else {
          customtoast('Teacher not found');
          FirebaseAuth.instance.signOut();
          setState(() {
            isauthenticating = false;
          });
        }
      });

      // setState(() {
      //   isauthenticating = false;
      // });
      // Get.to(
      //   () => const SubjectsPage(),
      // );
      // customtoast('Login Successful');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isauthenticating = false;
      });
      if (e.code == 'user-not-found') {
        Get.snackbar('Invalid user', 'No user found for that email');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Warning!', 'Wrong password provided for that user');
        // print('Wrong password provided for that user.');
      }
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
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WavyDesign2(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: responsiveHW(context, ht: 37),
                      decoration: const BoxDecoration(
                        color: Color(0x22009688),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WavyDesign3(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: responsiveHW(context, ht: 37),
                      decoration: const BoxDecoration(
                        color: Color(0x44009688),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WavyDesign1(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/tuLogo.png',
                              width: responsiveHW(context, wd: 30),
                              height: responsiveHW(context, ht: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: responsiveHW(context, ht: 3)),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: responsiveHW(context, ht: 37),
                      decoration: const BoxDecoration(
                        color: Color(0xff009688),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHW(context, ht: 4)),
              Expanded(
                child: ListView(children: [
                  customTextField(
                    "Email",
                    false,
                    null,
                    _email,
                    (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please Enter Valid Email Address";
                      }
                    },
                    (value) {
                      _email.text = value!;
                    },
                    responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100),
                    InputBorder.none,
                    pIcon: Icons.email,
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 2),
                  ),
                  customTextField(
                    "Password",
                    passwordVisible,
                    IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        //choose the icon on based of passwordVisibility
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _passwordVisibility,
                    ),
                    _password,
                    (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Password";
                      }
                    },
                    (value) {
                      _password.text = value!;
                    },
                    responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100),
                    InputBorder.none,
                    pIcon: Icons.lock,
                  ),
                  SizedBox(
                    height: responsiveHW(context, ht: 3),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsiveHW(context, wd: 6)!.toDouble()),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Color(0xff009688)),
                        height: responsiveHW(context, ht: 6),
                        child: TextButton(
                          child: isauthenticating
                              ? const CircularProgressIndicator(
                                  // backgroundColor: Colors.white,
                                  color: Colors.white,
                                )
                              : customText(
                                  txt: "Login",
                                  // style: TextStyle(
                                  clr: Colors.white,
                                  fweight: FontWeight.w700,
                                  // fontSize: heightSize * 3 / 100),
                                ),
                          onPressed: isauthenticating
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isauthenticating = true;
                                    });
                                    _loginFunc(_email.text.trim(),
                                        _password.text.trim());
                                  }
                                  // Get.to(() => const SubjectsPage());
                                },
                        ),
                      )),
                  SizedBox(
                    height: responsiveHW(context, ht: 0.8),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const ForgotPassword();
                            });
                      },
                      child: Text(
                        "Forgotten password?",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: responsiveHW(context, ht: 1.8),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4 / 100,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 5 / 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4 / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an Account ? ",
                        style: TextStyle(
                            // color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).size.height * 2 / 100,
                            fontWeight: FontWeight.normal),
                      ),
                      TextButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w700,
                            fontSize:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const AddTeacher(), arguments: [
                            {
                              "pageTitle": "Add Teacher",
                              "buttonText": "Submit",
                              'teacher_name': '',
                              'designation': '',
                              'department': '',
                              'imgUrl': '',
                              'teacherId': '',
                            }
                          ]);
                        },
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
