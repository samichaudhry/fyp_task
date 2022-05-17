import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/utils.dart';
import 'package:fyp_task/wavy_design.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var imgPath = '';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _designation = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  // Custom Sized Box
  SizedBox customSizedBox({height = 2}) => SizedBox(
        height: responsiveHW(context, ht: height),
      );

  // Visibility of password
  void _passwordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _confirmPasswordVisibility() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          "Add Teacher",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WavyDesign2(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: responsiveHW(context, ht: 25),
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
                    height: responsiveHW(context, ht: 25),
                    decoration: const BoxDecoration(
                      color: Color(0x44009688),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WavyDesign1(),
                  child: Container(
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              filepicker().then((selectedpath) {
                                if (selectedpath.toString().isNotEmpty) {
                                  setState(() {
                                    imgPath = selectedpath;
                                  });
                                }
                              });
                            },
                            child: CircleAvatar(
                              radius: 50.0,
                              foregroundImage: FileImage(File(imgPath)),
                              child: const Icon(
                                Icons.person,
                                size: 80.0,
                                color: Colors.white,
                              ),
                            )),
                        customSizedBox(height: 1),
                        Text(
                          "Select Profile Image",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: responsiveHW(context, ht: 2)),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: responsiveHW(context, ht: 25),
                    decoration: const BoxDecoration(
                      color: Color(0xff009688),
                    ),
                  ),
                ),
              ],
            ),
            customSizedBox(height: 4),
            Expanded(
                child: ListView(
              children: [
                customTextField("Name", Icons.edit, false, null, _name,
                    (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher Name ";
                  }
                  if (!RegExp(r"^[A-Z+a-z]+").hasMatch(value)) {
                    return "Please Enter Valid Name";
                  }
                }, (value) {
                  _name.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                customSizedBox(),
                customTextField("Designation", Icons.workspace_premium_outlined,
                    false, null, _designation, (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher's Designation";
                  }
                  if (!RegExp(r"^[a-z+A-Z]+").hasMatch(value)) {
                    return "Please Enter Valid Designation";
                  }
                }, (value) {
                  _designation.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                customSizedBox(),
                customTextField("Department", FontAwesomeIcons.building, false,
                    null, _department, (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher's Department";
                  }
                  if (!RegExp(r"^[a-z+A-Z]+").hasMatch(value)) {
                    return "Please Enter Valid Department";
                  }
                }, (value) {
                  _department.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                customSizedBox(),
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
                customSizedBox(),
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
                    return "Please enter your password";
                  }
                  if (value.length < 8) {
                    return "Password length must be atleast 8 characters";
                  }
                }, (value) {
                  _password.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                customSizedBox(),
                customTextField(
                    "Confirm Password",
                    Icons.lock,
                    confirmPasswordVisible,
                    IconButton(
                      icon: Icon(
                        //choose the icon on based of passwordVisibility
                        confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _confirmPasswordVisibility,
                    ),
                    _confirmpass, (value) {
                  if (value!.isEmpty) {
                    return "Please Re-Enter Your Password";
                  }
                  if (value != _password.text) {
                    return "Both Password Should Be Matched";
                  }
                }, (value) {
                  _confirmpass.text = value!;
                }, responsiveHW(context, wd: 100),
                    responsiveHW(context, ht: 100)),
                customSizedBox(height: 3),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsiveHW(context, wd: 6)!.toDouble()),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xff009688)),
                      height: responsiveHW(context, ht: 6),
                      child: TextButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: responsiveHW(context, ht: 3)),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
