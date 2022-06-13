import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/login_page.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'custom widgets/custom_toast.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var imgPath = '';
  String? downloadImgUrl = '';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _designation = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool isauthenticating = false;
  bool isImageSelected = false;

  var editProfileArgument = Get.arguments;
  String? teacherId;

  @override
  void initState() {
    super.initState();

    _name.text = editProfileArgument[0]['teacher_name'];
    _department.text = editProfileArgument[0]['department'];
    _designation.text = editProfileArgument[0]['designation'];
    teacherId = editProfileArgument[0]['teacherId'];
  }

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

  //backend Functionality

  CollectionReference teachers =
      FirebaseFirestore.instance.collection('teachers');

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref('images/profile_pictures/$teacherId.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      Get.snackbar('Error occured.', '$e');
    }
  }

  Future<void> downloadURLfunc(teacherName) async {
    String imgurl = await FirebaseStorage.instance
        .ref('images/profile_pictures/$teacherId.png')
        .getDownloadURL();
    setState(() {
      downloadImgUrl = imgurl;
    });
  }

  Future _addTeacherQuery() async {
    FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadImgUrl);
    return editProfileArgument[0]["pageTitle"].toString() == "Add Teacher"
        ? teachers.doc(teacherId).set({
            'isTeacher': true,
            'status': 'Pending',
            'teacher_name': _name.text.trim(),
            'designation': _designation.text.trim(),
            'department': _department.text.trim(),
            'email': _email.text.trim(),
            'imgUrl': downloadImgUrl,
          }, SetOptions(merge: true))
        : teachers.doc(teacherId).set({
            // 'isTeacher': true,
            'teacher_name': _name.text.trim(),
            'designation': _designation.text.trim(),
            'department': _department.text.trim(),
            'imgUrl': (isImageSelected)
                ? downloadImgUrl
                : editProfileArgument[0]['imgUrl'],
          }, SetOptions(merge: true));
  }

  Future<void> saveTeacherData() async {
    return _addTeacherQuery().then((value) {
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile"
          ? null
          : _name.clear();
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile"
          ? null
          : _designation.clear();
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile"
          ? null
          : _department.clear();
      _email.clear();
      _password.clear();
      _confirmpass.clear();
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile"
          ? customtoast("Teacher's Data Updated")
          : rawsnackbar('Your request is submitted to admin. you can login only after the approval request');
    setState(() {
        isauthenticating = false;
      });
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile" ?
      null
      :
      Get.to(
        () => const LoginPage(),
      );
    }).catchError((error) {
      editProfileArgument[0]['pageTitle'] == "Edit Teacher's Profile"
          ? customtoast("Failed to update Teacher's data: $error")
          : customtoast("Failed to add Teacher: $error");
    });
  }

  Future<void> addTeacherData() async {
    if (isImageSelected) {
      uploadFile(imgPath).then((value) {
        downloadURLfunc(_name.text).then((value) {
          saveTeacherData();
        });
      });
    } else {
      saveTeacherData();
    }
  }

  // signup for teachers

  Future _createuserwithemail(useremail, userpassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: useremail, password: userpassword);
              setState(() {
                teacherId = userCredential.user?.uid;
              });
      await addTeacherData();

     
      // Get.rawSnackbar(
      //   messageText: const Text(
      //     'Ask Teachers To verify his/her email',
      //     style: TextStyle(
      //       fontSize: 17.0,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.white,
      //     ),
      //   ),
      // );

    } on FirebaseAuthException catch (e) {
      setState(() {
        isauthenticating = false;
      });
      if (e.code == 'weak-password') {
        Get.snackbar('', 'Password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('', 'Account already exists for that email.');
      }
    } catch (e) {
      setState(() {
        isauthenticating = false;
      });
      Get.snackbar('', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              centerTitle: true,
              pinned: true,
              snap: true,
              floating: true,
              elevation: 0.0,
              title: customText(
                txt: editProfileArgument[0]["pageTitle"].toString(),
                clr: Colors.white,
                fsize: 20.0,
                fweight: FontWeight.w500,
              ),
              expandedHeight: responsiveHW(context, ht: 8),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: responsiveHW(context, wd: 100),
                height: responsiveHW(context, ht: 23),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    customSizedBox(height: 1),
                    GestureDetector(
                      onTap: () {
                        filepicker(filetype: FileType.image)
                            .then((selectedpath) {
                          if (selectedpath.toString().isNotEmpty) {
                            setState(() {
                              imgPath = selectedpath;
                              isImageSelected = true;
                            });
                          }
                        });
                      },
                      child: isImageSelected
                          ? CircleAvatar(
                              radius: 50.0,
                              foregroundImage: FileImage(File(imgPath)),
                              child: const Icon(
                                Icons.person,
                                size: 80.0,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 50.0,
                              foregroundImage: NetworkImage(
                                  editProfileArgument[0]['imgUrl'].toString()),
                              backgroundColor: Colors.black26,
                              child: const Icon(
                                Icons.person,
                                size: 80.0,
                                color: Colors.white,
                              ),
                            ),
                    ),
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
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(
                bottom: responsiveHW(context, ht: 3)!.toDouble(),
              )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              customTextField(
                "Name",
                false,
                null,
                _name,
                (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher Name ";
                  }
                  if (!RegExp(r"^[A-Z+a-z]+").hasMatch(value)) {
                    return "Please Enter Valid Name";
                  }
                },
                (value) {
                  _name.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
                InputBorder.none,
                pIcon: Icons.edit,
              ),
              customSizedBox(),
              customTextField(
                "Designation",
                false,
                null,
                _designation,
                (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher's Designation";
                  }
                  if (!RegExp(r"^[a-z+A-Z]+").hasMatch(value)) {
                    return "Please Enter Valid Designation";
                  }
                },
                (value) {
                  _designation.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
                InputBorder.none,
                pIcon: Icons.workspace_premium_outlined,
              ),
              customSizedBox(),
              customTextField(
                "Department",
                false,
                null,
                _department,
                (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Teacher's Department";
                  }
                  if (!RegExp(r"^[a-z+A-Z]+").hasMatch(value)) {
                    return "Please Enter Valid Department";
                  }
                },
                (value) {
                  _department.text = value!;
                },
                responsiveHW(context, wd: 100),
                responsiveHW(context, ht: 100),
                InputBorder.none,
                pIcon: FontAwesomeIcons.building,
              ),
              customSizedBox(),
              editProfileArgument[0]["pageTitle"].toString() == "Add Teacher"
                  ? customTextField(
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
                    )
                  : customSizedBox(height: 0),
              customSizedBox(),
              editProfileArgument[0]["pageTitle"].toString() == "Add Teacher"
                  ? customTextField(
                      "Password",
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
                      _password,
                      (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 8) {
                          return "Password length must be atleast 8 characters";
                        }
                      },
                      (value) {
                        _password.text = value!;
                      },
                      responsiveHW(context, wd: 100),
                      responsiveHW(context, ht: 100),
                      InputBorder.none,
                      pIcon: Icons.lock,
                    )
                  : customSizedBox(height: 0),
              editProfileArgument[0]["pageTitle"].toString() == "Add Teacher"
                  ? customSizedBox()
                  : customSizedBox(height: 0),
              editProfileArgument[0]["pageTitle"].toString() == "Add Teacher"
                  ? customTextField(
                      "Confirm Password",
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
                      _confirmpass,
                      (value) {
                        if (value!.isEmpty) {
                          return "Please Re-Enter Your Password";
                        }
                        if (value != _password.text) {
                          return "Both Password Should Be Matched";
                        }
                      },
                      (value) {
                        _confirmpass.text = value!;
                      },
                      responsiveHW(context, wd: 100),
                      responsiveHW(context, ht: 100),
                      InputBorder.none,
                      pIcon: Icons.lock,
                    )
                  : customSizedBox(height: 0),
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
                      onPressed: isauthenticating
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isauthenticating = true;
                                });
                                editProfileArgument[0]["pageTitle"]
                                            .toString() ==
                                        "Add Teacher"
                                    ? _createuserwithemail(_email.text.trim(),
                                        _password.text.trim())
                                    : addTeacherData();
                              }
                            },
                      child: isauthenticating
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              editProfileArgument[0]['buttonText'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: responsiveHW(context, ht: 3)),
                            ),
                    ),
                  ))
            ]))
          ],
        ),
      ),
    );
  }
}