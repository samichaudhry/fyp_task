import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_task/admin/attendance_data.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class AttendanceRecord extends StatefulWidget {
  const AttendanceRecord({Key? key}) : super(key: key);

  @override
  State<AttendanceRecord> createState() => _AttendanceRecordState();
}

class _AttendanceRecordState extends State<AttendanceRecord> {
  List semesters = [
    {
      'name': 'Spring 2020',
      'ontap': '',
    },
    {
      'name': 'Fall 2020',
      'ontap': '',
    },
    {
      'name': 'Fall 2021',
      'ontap': '',
    },
    {
      'name': 'Spring 2021',
      'ontap': '',
    },
    {
      'name': 'Spring 2022',
      'ontap': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: true,
            snap: true,
            title: customText(
              txt: 'Semesters',
              clr: Colors.white,
              fsize: 20.0,
              fweight: FontWeight.w500,
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         myfunc();
            //       },
            //       icon: Icon(Icons.ad_units_sharp)),
            // ],
            expandedHeight: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height * 0.08
                : MediaQuery.of(context).size.height * 0.45,
          ),
          const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(
              bottom: 2.5,
            )),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const AttendanceData(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .withOpacity(0.4),
                    ),
                    margin: const EdgeInsets.all(3.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: customText(
                                txt: '${semesters[index]['name']}',
                                fsize: 20.0,
                                clr: Colors.white,
                                fweight: FontWeight.w500),
                          ),
                          // customText(
                          //     txt: 'CSE 4th Year',
                          //     fsize: 19.0,
                          //     clr: Colors.white,
                          //     fweight: FontWeight.w400),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: semesters.length,
            ),
          )
        ],
      ),
    );
  }
}
