import 'package:flutter/material.dart';
import 'package:fyp_task/admin/add_subject.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class SubjectInfo extends StatefulWidget {
  const SubjectInfo({Key? key}) : super(key: key);

  @override
  State<SubjectInfo> createState() => _SubjectInfoState();
}

class _SubjectInfoState extends State<SubjectInfo> {
  var imgUrl =
      "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png";

  // Custom Sized Box
  SizedBox customSizedBox({height = 2}) => SizedBox(
        height: responsiveHW(context, ht: height),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              txt: "Subject's Info",
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
                        text: "Subject Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: responsiveHW(context, ht: 2.5),
                        ),
                        children: [
                          TextSpan(
                            text: "\nBSCS-8th-SS (2018-2022)",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: responsiveHW(context, ht: 2)),
                          ),
                        ]),
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveHW(context, wd: 6)!.toDouble()),
              child: customButton("Edit Subject", () {
                Get.to(() => const AddSubject(), arguments: [
                  {
                    "pageTitle": "Edit Subject's Details",
                    "buttonText": "Update"
                  }
                ]);
              }, context, 100),
            ),
            customSizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveHW(context, wd: 6)!.toDouble()),
              child: customButton("Delete Subject", () {}, context, 100),
            ),
          ]))
        ],
      ),
    );
  }
}
