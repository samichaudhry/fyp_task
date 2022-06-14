import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_toast.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            height: responsiveHW(context, ht: 9),
            width: responsiveHW(context, wd: 100),
            alignment: Alignment.center,
            // decoration: const BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            //   color: Colors.teal,
            // ),
            child: const Text(
              "Forgot Your Password?",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Container(
                height: responsiveHW(context, ht: 8),
                width: responsiveHW(context, wd: 80),
                alignment: Alignment.center,
                child: const Text(
                  "Enter the Email address associated with your account",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: responsiveHW(context, ht: 2),
              ),
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
                height: responsiveHW(context, ht: 3),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveHW(context, wd: 6)!.toDouble(),
                ),
                child: customButton("Verify Email", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _email.text.trim());
                  customtoast('Reset Link Sent.');
                  Navigator.pop(context);
                }, context, 200),
              ),
              SizedBox(
                height: responsiveHW(context, ht: 3),
              ),
              Container(
                height: responsiveHW(context, ht: 30),
                width: responsiveHW(context, ht: 30),
                color: Colors.transparent,
                child: Image.asset(
                  "assets/forgetPassword.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: responsiveHW(context, ht: 3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
