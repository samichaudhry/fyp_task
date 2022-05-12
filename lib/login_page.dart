import 'package:fyp_task/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom_widgets.dart';
import 'package:fyp_task/forget_password.dart';
import 'package:fyp_task/utils.dart';

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

  // Visibility of password
  void _passwordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(children: [
                customTextField("Email", Icons.email, false, null, _email,
                    (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Email";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Please Enter Valid Email Address";
                  }
                }, (value) {
                  _email.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                SizedBox(
                  height: responsiveHW(context, ht: 2),
                ),
                customTextField(
                    "Password",
                    Icons.lock,
                    passwordVisible,
                    IconButton(
                      icon: Icon(
                        //choose the icon on based of passwordVisibility
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _passwordVisibility,
                    ),
                    _password, (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Password";
                  }
                }, (value) {
                  _password.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                SizedBox(
                  height: responsiveHW(context, ht: 3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsiveHW(context, wd: 6)!.toDouble()),
                  child: customButton("Login", () {}, context, 35),
                ),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
