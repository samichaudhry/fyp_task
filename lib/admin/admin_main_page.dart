import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/admin/sessions_page.dart';
import 'package:fyp_task/admin/teachers_page.dart';
// import 'package:font_awesome_flutter/src/fa_icon.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  List OptionsList = [
    {
      'title': "Teachers",
      'icon': FontAwesomeIcons.personChalkboard,
      'route': const TeachersPage(),
      'color': const Color(0xff245469)
    },
    {
      'title': "Students",
      'icon': FontAwesomeIcons.userGraduate,
      'route': () => const sessionpage(),
      'color': const Color(0xff2A5E75)
    },
    // {
    //   'title': "Today's Attendance Report",
    //   'icon': FontAwesomeIcons.fileContract,
    //   'route': const SubjectsPage(),
    //   'color': const Color(0xff314554)
    // },
    {
      'title': "Attendance Record",
      'icon': FontAwesomeIcons.filePrescription,
      'route': const SubjectsPage(),
      'color': const Color(0xff263E52)
    },
    {
      'title': "Change Password",
      'icon': FontAwesomeIcons.key,
      'route': const SubjectsPage(),
      'color': const Color(0xff0F2030)
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            centerTitle: true,
            pinned: true,
            snap: true,
            floating: true,
            elevation: 0.0,
            title: customText(
              txt: 'Admin Panel',
              clr: Colors.white,
              fsize: 20.0,
              fweight: FontWeight.w500,
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_sharp),
                label: customText(txt: 'Logout', clr: Colors.white),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  elevation: 0.0,
                ),
              ),
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.08,
          ),
          SliverToBoxAdapter(
            child: Container(
              // padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 40.0,
                      // backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.userGear,
                        size: 30.0,
                        // color: Colors.white,
                      ),
                      foregroundImage: NetworkImage('url here'),
                    ),
                  ),
                  Center(
                    child: customText(
                        txt: 'Admin Name',
                        fsize: 19.0,
                        fweight: FontWeight.w500),
                  ),
                  Center(
                    child: customText(txt: 'admin@gmail.com', fsize: 18.0),
                  ),
                ],
              ),
            ),
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
                      OptionsList[index]['route'],
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: OptionsList[index]['color'],
                    ),
                    margin: const EdgeInsets.all(3.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              OptionsList[index]['icon'],
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                          Center(
                            child: customText(
                              txt: '${OptionsList[index]['title']}',
                              fsize: 20.0,
                              clr: Colors.white,
                              fweight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: OptionsList.length,
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.teal,
      //   child: const Icon(
      //     Icons.add,
      //     size: 25.0,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
