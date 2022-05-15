import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:fyp_task/utils.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  List OptionsList = [
    {
      'title' : "Teachers",
      'icon' : Icons.supervised_user_circle_sharp,
      'route' : const SubjectsPage(),
      'color' : const Color(0xff808C9D)
    },
    {
      'title' : "Students",
      'icon' : Icons.abc_rounded,
      'route' : const SubjectsPage(),
      'color' : const Color(0xff588983)
    },
    {
      'title' : "Today's Attendance Report",
      'icon' :  FontAwesomeIcons.file,
      'route' : const SubjectsPage(),
      'color' : const Color(0xff419F89)
    },
    {
      'title' : "Attendance Record",
      'icon' :  FontAwesomeIcons.filePrescription,
      'route' : const SubjectsPage(),
      'color' : const Color(0xff31493D)
    },
    {
      'title' : "Change Password",
      'icon' :  FontAwesomeIcons.key,
      'route' : const SubjectsPage(),
      'color' :  Colors.blueGrey.withOpacity(5.0)
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
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              child: ListView(
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 40.0,
                      // backgroundColor: Colors.white,
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 80.0,
                        // color: Colors.white,
                      ),
                      foregroundImage: NetworkImage('url here'),
                    ),
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
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color:  Colors.teal,
                          // .withOpacity(0.4),
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
                              // color: Colors.white,
                              size: 70.0,
                            ),
                          ),
                          Center(
                            child: customText(
                              txt: '${OptionsList[index]['title']}',
                              fsize: 22.0,
                              // clr: Colors.white,
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
