import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_toast.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/user profile/profile_widget.dart';
import 'package:fyp_task/user%20profile/edit_profile.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

import '../custom widgets/custom_widgets.dart';

class teacherprofile extends StatefulWidget {
  const teacherprofile({Key? key}) : super(key: key);

  @override
  State<teacherprofile> createState() => _teacherprofileState();
}

class _teacherprofileState extends State<teacherprofile> {
  var teacherdata;
  var currentuserid;
  bool isworking = false;
  bool isloading = true;
  var useremail;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _oldemail = TextEditingController();
  final TextEditingController _oldpassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    User? currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      currentuserid = FirebaseAuth.instance.currentUser?.uid;
      useremail = FirebaseAuth.instance.currentUser?.email;
    }
  }

  Future teacherprofiledata() async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(currentuserid)
        .get()
        .then((DocumentSnapshot teacher) {
      teacherdata = teacher.data();
    });
    setState(() {
      isloading = false;
    });
    print(teacherdata);
  }

  Future changeemail() async {
    // isworking = false;
    _email.clear();
    _oldemail.clear();
    _oldpassword.clear();
    // _newpassword.clear();

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, innerstate) {
        return AlertDialog(
          title: const Center(child: Text('Change Email')),
          contentPadding: const EdgeInsets.all(10.0),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: responsiveHW(context, ht: 3),
                ),
                customTextField(
                  "New Email",
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
                  "Current Password",
                  true,
                  null,
                  _oldpassword,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    }
                  },
                  (value) {
                    _oldpassword.text = value!;
                  },
                  responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100),
                  InputBorder.none,
                  pIcon: Icons.lock,
                ),
                SizedBox(
                  height: responsiveHW(context, ht: 3),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            isworking
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.0),
                    child: CircularProgressIndicator(),
                  )
                : MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        innerstate(() {
                          isworking = true;
                        });
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .reauthenticateWithCredential(
                                  EmailAuthProvider.credential(
                                      email: useremail,
                                      password: _oldpassword.text.trim()));
                          try {
                            await FirebaseAuth.instance.currentUser!
                                .updateEmail(_email.text.trim());
                            innerstate(() {
                              isworking = false;
                            });
                            // FirebaseAuth.instance.signOut();
                            // Get.to(
                            //   () => const LoginPage(),
                            // );
                            customtoast('Email changed successfully');
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            innerstate(() {
                              isworking = false;
                            });
                            if (e.code == 'email-already-in-use') {
                              rawsnackbar('Email already in use');
                            } else if (e.code == 'invalid-email') {
                              rawsnackbar('Email already in use');
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          innerstate(() {
                            isworking = false;
                          });
                          if (e.code == 'wrong-password') {
                            rawsnackbar('Wrong Password');
                            // print('Wrong password provided for that user.');
                          }
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    teacherprofiledata();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : Stack(
              children: [
                const Padding(
                  padding: const EdgeInsets.only(top: 44),
                  child: BackButton(),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //      SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.07,
                        // ),
                        //  ProfileWidget(
                        //  imagePath: '${teacherdata["imgUrl"]}',
                        //  onClicked: () async {
                        //    Get.to(() => const edit_profile(), arguments: {
                        //  'teacher_name': '${teacherdata["teacher_name"]}',
                        //  'imgUrl': '${teacherdata["imgUrl"]}',
                        //  'designation': '${teacherdata["designation"]}',
                        //  'department': '${teacherdata["department"]}',
                        //  // 'email': '${teacherdata["email"]}',
                        //    });
                        //  },
                        //  icon: Icons.edit,
                        //  ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        customText(
                            txt: '${teacherdata["teacher_name"]}',
                            fweight: FontWeight.bold,
                            fsize: 24.0),
                        Center(
                            child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: changeemail,
                            label: customText(
                                txt:
                                    '${FirebaseAuth.instance.currentUser?.email}',
                                fsize: 19.0,
                                clr: Colors.white),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.teal,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Center(
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: "Designation: ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.teal,
                                  ),
                                ),
                                TextSpan(
                                  text: "${teacherdata['designation']} \n",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Department: ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.teal,
                                  ),
                                ),
                                TextSpan(
                                  text: "${teacherdata['department']}\n",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ])),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        customText(
                          txtalign: TextAlign.center,
                          txt: 'THAL UNIVERSITY\n BHAKKAR',
                          fsize: 23.0,
                          fweight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // top: MediaQuery.of(context).size.height * 0.14,
                  // left: MediaQuery.of(context).size.height * 0.16,
                  height:MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width* 1.0,
                  child: ProfileWidget(
                    imagePath: '${teacherdata["imgUrl"]}',
                    onClicked: () async {
                      Get.to(() => const edit_profile(), arguments: {
                        'teacher_name': '${teacherdata["teacher_name"]}',
                        'imgUrl': '${teacherdata["imgUrl"]}',
                        'designation': '${teacherdata["designation"]}',
                        'department': '${teacherdata["department"]}',
                        // 'email': '${teacherdata["email"]}',
                      });
                    },
                    icon: Icons.edit,
                  ),
                ),
              ],
            ),
    );
  }
}
