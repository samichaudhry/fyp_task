import 'package:flutter/material.dart';
import 'package:fyp_task/admin/add_teacher.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';
import 'package:fyp_task/wavy_design.dart';
import 'package:get/get.dart';

class TeacherInfo extends StatefulWidget {
  const TeacherInfo({Key? key}) : super(key: key);

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  var imgUrl =
      "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png";

  // Custom Sized Box
  SizedBox customSizedBox({height = 2}) => SizedBox(
        height: responsiveHW(context, ht: height),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          "Teacher's Info",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WavyDesign2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: responsiveHW(context, ht: 30),
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
                  height: responsiveHW(context, ht: 30),
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
                      CircleAvatar(
                        radius: 50.0,
                        foregroundImage: NetworkImage(imgUrl),
                        child: const Icon(
                          Icons.person,
                          size: 80.0,
                          color: Colors.white,
                        ),
                      ),
                      customSizedBox(height: 1),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Teacher Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: responsiveHW(context, ht: 2.5),
                            ),
                            children: [
                              TextSpan(
                                text: "\nabc123@gmail.com",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsiveHW(context, ht: 2)),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: responsiveHW(context, ht: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xff009688),
                  ),
                ),
              ),
            ],
          ),
          customSizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveHW(context, wd: 6)!.toDouble()),
            child: customButton("View Subjects", () {}, context, 100),
          ),
          customSizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveHW(context, wd: 6)!.toDouble()),
            child: customButton("Edit Profile", () {
              Get.to(() => const AddTeacher(), arguments: [
                {"pageTitle": "Edit Teacher's Profile", "buttonText": "Update"}
              ]);
            }, context, 100),
          ),
          customSizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveHW(context, wd: 6)!.toDouble()),
            child: customButton("Delete Profile", () {}, context, 100),
          ),
        ],
      ),
    );
  }
}
