import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/user profile/profile_widget.dart';
import 'package:fyp_task/user%20profile/edit_profile.dart';
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
  @override
  void initState() {
    super.initState();
    User? currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      currentuserid = FirebaseAuth.instance.currentUser?.uid;
    } 
  }

Future teacherprofiledata() async {
   await FirebaseFirestore.instance.collection('teachers').doc(currentuserid).get().then((DocumentSnapshot teacher){
      teacherdata = teacher.data();
    });
    setState(() {
    });
      print(teacherdata);

  }

  @override
  Widget build(BuildContext context) {
      teacherprofiledata();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          ProfileWidget(
            imagePath:
                '${teacherdata["imgUrl"]}',
            onClicked: () async {
            Get.to(
              () => const edit_profile(),
              arguments: {
                'teacher_name': '${teacherdata["teacher_name"]}',
                'imgUrl': '${teacherdata["imgUrl"]}',
                'designation': '${teacherdata["designation"]}',
                'department': '${teacherdata["department"]}',
                // 'email': '${teacherdata["email"]}',
              }
            );
            },
            icon: Icons.edit,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.019,
          ),
          Column(
            children: [
              customText(
                  txt: '${teacherdata["teacher_name"]}',
                  fweight: FontWeight.bold,
                  fsize: 24.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              customText(txt: '${teacherdata["email"]}'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.left,
                text:  TextSpan(children: [
                  const TextSpan(
                    text: "Designation: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.teal,
                    ),
                  ),
                  TextSpan(
                    text: "${teacherdata['designation']} \n",
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(
                    text: "Department: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.teal,
                    ),
                  ),
                  TextSpan(
                    text: "${teacherdata['department']}\n",
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ])),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 48),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       customText(
          //         txt: 'About',
          //         fsize: 24.0,
          //         fweight: FontWeight.bold,
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.02,
          //       ),
          //       customText(
          //         txt:
          //             'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
          //         fsize: 16.0,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
