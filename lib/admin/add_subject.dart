import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var imgPath = '';
  final TextEditingController _subjName = TextEditingController();
  final TextEditingController _subjCode = TextEditingController();
  final TextEditingController _program = TextEditingController();
  final TextEditingController _semester = TextEditingController();
  final TextEditingController _session = TextEditingController();
  var editSubjectArgument = Get.arguments;
  // Custom Sized Box
  SizedBox customSizedBox({height = 2}) => SizedBox(
        height: responsiveHW(context, ht: height),
      );

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
                txt: editSubjectArgument[0]["pageTitle"].toString(),
                clr: Colors.white,
                fsize: 20.0,
                fweight: FontWeight.w500,
              ),
              expandedHeight: responsiveHW(context, ht: 8),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: responsiveHW(context, wd: 100),
                height: responsiveHW(context, ht: 22),
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
                      "Select Subject Image",
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
                  "Subject Name", Icons.edit, false, null, _subjName, (value) {
                if (value!.isEmpty) {
                  return "Please Enter Subject Name";
                }
              }, (value) {
                _subjName.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customTextField(
                  "Subject Code", Icons.code, false, null, _subjCode, (value) {
                if (value!.isEmpty) {
                  return "Subject Code Required*";
                }
              }, (value) {
                _subjCode.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customTextField(
                  "Program", Icons.class__outlined, false, null, _program,
                  (value) {
                if (value!.isEmpty) {
                  return "Required*";
                }
              }, (value) {
                _program.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customTextField("Semester", Icons.format_list_numbered_sharp,
                  false, null, _semester, (value) {
                if (value!.isEmpty) {
                  return "Required*";
                }
              }, (value) {
                _semester.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customTextField("Session", Icons.screen_search_desktop_outlined,
                  false, null, _session, (value) {
                if (value!.isEmpty) {
                  return "Required*";
                }
              }, (value) {
                _session.text = value!;
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
                        editSubjectArgument[0]['buttonText'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: responsiveHW(context, ht: 3)),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ))
            ]))
          ],
        ),
      ),
    );
  }
}
