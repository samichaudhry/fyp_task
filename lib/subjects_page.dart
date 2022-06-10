import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/attendance_sheet.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/login_page.dart';
import 'package:fyp_task/user%20profile/teacher_profile.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  bool isloggedin = false;
  String photourl = '';
  String? useremail = 'abc@gmail.com';
  String? username = '';
  var currentuserid;
  @override
  void initState() {
    super.initState();
    User? currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      currentuserid = FirebaseAuth.instance.currentUser?.uid;
      // photourl = currentuser.photoURL;
      useremail = currentuser.email;
      teacherprofiledata();
    } 
  }

  Future teacherprofiledata() async {
    await FirebaseFirestore.instance.collection('teachers').doc(currentuserid).get().then((DocumentSnapshot teacher){
      username = teacher['teacher_name'];
      photourl = '${teacher["imgUrl"]}';
    });
    setState(() {
      
    });
  }

  // Future dummydata() async {
  //   final DateTime now = DateTime.now();
  // final DateFormat formatter = DateFormat('dd-MM-yyyy');
  // final String formatted = formatter.format(now);
  // print(formatted); // something like 2013-04-20
  //   FirebaseFirestore.instance
  //       .collection('attendance')
  //       .doc('Q0QUhhsjYir1pK7fzTfQ')
  //       .collection('attendancedata')
  //       .doc()
  //       .set({
  //         'studentid' : 'YjFngBXuMn6s2aVIMIsZ',
  //         'attendance_status': 'P',
  //         'sessionid' : 'TrODKYmoeolUPgtjjk4Q',
  //         'attendancedate': formatted,
  //       }, SetOptions(merge: true));
  // }

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

  Future<void> logoutfunc() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('you want to logout?'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          MaterialButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              setState(() {
                isloggedin = false;
              });
              Get.to(
                () => const LoginPage(),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // dummydata();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('subjects')
                .doc(currentuserid)
                .collection('teacherSubjects')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var data = snapshot.data?.docs;
              if (snapshot.hasError) {
                // print(snapshot.error);
                return const Center(
                  child: Text('Something Went Wrong'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
              }
              if (data!.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
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
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.hourglass_empty,
                              size: 65.0,
                            ),
                          ),
                          Center(
                            child: customText(
                                txt: 'No Subject Found',
                                fsize: 25.0,
                                fweight: FontWeight.w500, padding: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
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
                          var ds = snapshot.data?.docs[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const AttendanceSheet(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)]
                                    .withOpacity(0.4),
                              ),
                              margin: const EdgeInsets.all(3.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                        txt: '${ds!['subject_name']}',
                                        fsize: 20.0,
                                        clr: Colors.white,
                                        fweight: FontWeight.w500),
                                    // customText(
                                    //     txt: '${ds['subject_code']}',
                                    //     fsize: 19.0,
                                    //     clr: Colors.white,
                                    //     fweight: FontWeight.w400),
                                    customText(
                                        txt:
                                            '${ds['program']} ${ds['session']}',
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
                                      txt:
                                          '${ds['start_duration']} to ${ds['end_duration']}',
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
                        childCount: data.length,
                      ),
                    )
                  ],
                ),
              );
            }),
        drawer: Drawer(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                accountEmail: customText(txt: '$useremail', clr: Colors.white),
                accountName: customText(txt: '$username', clr: Colors.white),
                currentAccountPicture: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    foregroundImage: CachedNetworkImageProvider(photourl),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),
              customTile(
                ontap: () {
                  Get.to(
                    () => const teacherprofile(),
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
              // customTile(
              //   ontap: () {
              //     Get.to(
              //       () => const AdminMainPage(),
              //     );
              //   },
              //   leading: const Icon(
              //     FontAwesomeIcons.userShield,
              //     color: Colors.white,
              //     size: 30.0,
              //   ),
              //   title: customText(
              //     txt: 'Admin',
              //     clr: Colors.white,
              //     fweight: FontWeight.w500,
              //   ),
              // ),
              customTile(
                ontap: () {
                  logoutfunc();
                },
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
      ),
    );
  }
}
