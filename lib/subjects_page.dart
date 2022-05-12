import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_task/attendance_sheet.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/nav_menu.dart';
import 'package:fyp_task/user%20profile/user_profile.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List SubjectsList = [
    {
      'subject_name': 'Cloud Computing',
      'session': 'BSCS 2018-2022',
      'time': '08:00 AM to 09:30 AM',
    },
    {
      'subject_name': 'Operating System',
      'session': 'BSCS 2018-2022',
      'time': '09:30 AM to 11:00 AM',
    },
    {
      'subject_name': 'Professional Practices',
      'session': 'BSCS 2018-2022',
      'time': '11:00 AM to 12:30 PM',
    },
    {
      'subject_name': 'Object Oriented Programming',
      'session': 'BSCS 2018-2022',
      'time': '01:00 PM to 02:30 PM',
    },
    {
      'subject_name': 'Database Systems',
      'session': 'BSCS 2018-2022',
      'time': '02:30 PM to 04:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,

              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(20),
              //     bottomRight: Radius.circular(20),
              //   ),
              // ),
              title: customText(
                txt: 'Subjects',
                clr: Colors.white,
                fsize: 20.0,
                fweight: FontWeight.w500,
              ),

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
                        () => const AttendanceSheet(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)]
                            .withOpacity(0.4),
                      ),
                      margin: const EdgeInsets.all(3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                txt: '${SubjectsList[index]['subject_name']}',
                                fsize: 20.0,
                                clr: Colors.white,
                                fweight: FontWeight.w500),
                            // customText(
                            //     txt: 'CSE 4th Year',
                            //     fsize: 19.0,
                            //     clr: Colors.white,
                            //     fweight: FontWeight.w400),
                            customText(
                                txt: '${SubjectsList[index]['session']}',
                                fsize: 18.0,
                                clr: Colors.white,
                                fweight: FontWeight.w400),
                            // customText(
                            //   txt: 'Student: 11',
                            //   fsize: 18.0,
                            //   clr: Colors.white,
                            //   fweight: FontWeight.w400,
                            // ),
                            customText(
                              txt: '${SubjectsList[index]['time']}',
                              fsize: 16.0,
                              clr: Colors.white,
                              fweight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: SubjectsList.length,
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountEmail:
                    customText(txt: 'abc@gmail.com', clr: Colors.white),
                accountName: customText(txt: 'Teacher', clr: Colors.white),
                currentAccountPicture: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.grey,
                      size: 50.0,
                    ),
                    radius: 45.0,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(
                    () => const UserProfile(),
                  );
                },
                leading: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                title: customText(
                  txt: 'Profile',
                  clr: Colors.white,
                  fweight: FontWeight.w500,
                ),
              ),
              customTile(
                ontap: () {},
                leading: const Icon(
                  Icons.percent_sharp,
                  color: Colors.white,
                  size: 30.0,
                ),
                title: customText(
                  txt: 'Percentage',
                  clr: Colors.white,
                  fweight: FontWeight.w500,
                ),
              ),
              customTile(
                ontap: () {},
                leading: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                  size: 30.0,
                ),
                title: customText(
                  txt: 'Logout',
                  clr: Colors.white,
                  fweight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            size: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
