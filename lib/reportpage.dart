// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/percentage_page.dart';
import 'package:get/get.dart';

import 'custom widgets/custom_widgets.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime pickedDate = DateTime.now();
  var args = Get.arguments;
  List studentslist = [];
  // List studentdata = [
  //   {'name': 'Rustum shakeel', 'roll_no': 'BCSF18BM001', 'status': 'A'},
  //   {'name': 'Aamna Malik', 'roll_no': 'BCSF18BM002', 'status': 'A'},
  //   {'name': 'Sami Ullah', 'roll_no': 'BCSF18BM003', 'status': 'P'},
  //   {'name': 'Usman feyaz', 'roll_no': 'BCSF18BM004', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Alii', 'roll_no': 'BCSF18BM006', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'P'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  //   {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005', 'status': 'A'},
  // ];
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;
  bool isloading = true;
  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    // pickedDate =DateTime.now();
    // _pickedDate();
    _scrollController = ScrollController()..addListener(_scrollListener);
    studentsdata();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  Future studentsdata() async {
    print(args['date']);
    print(args['session_id']);
    print(args['subject_id']);
    await FirebaseFirestore.instance
        .collection('attendance')
        .doc(args['subject_id'])
        .collection('attendancedata')
        .where('attendancedate', isEqualTo: args['date'].toString())
        .where('session_id', isEqualTo: args['session_id'])
        // .orderBy('rollno', descending: false)
        .get()
        .then((QuerySnapshot students) {
      print('yeyjsb');
      print(students.docs.length);
      for (var student in students.docs) {
        print(student.data());
        List data = student['attendancerecord'];
        for (var std in data) {
          studentslist.add({
            'name': std['name'],
            'rollno': std['rollno'],
            'status': std['status'],
            'studentid': std['studentid'],
          });
        }
      }
    });
    setState(() {
      isloading = false;
    });
  }

  Widget customcircleavater(value) {
    Color? circlecolor;
    if (value == 'P' || value == 'p') {
      circlecolor = Colors.green;
    } else if (value == 'A' || value == 'a') {
      circlecolor = Colors.red;
    } else {
      circlecolor = Colors.black;
    }
    return CircleAvatar(
        backgroundColor: circlecolor,
        radius: 16.0,
        child: customText(
          txt: value,
          clr: Colors.white,
        ));
  }

  // Widget customlisttile(stdname, stdrollno, status, studentid) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
  //     child: ListTile(
  //       onTap: () {
  //         Get.to(() => const subject_percentage(), arguments: {
  //           'studentname': stdname,
  //           'studentrollno': stdrollno,
  //           'studentid': studentid,
  //           'session_id': args['session_id'],
  //           'semester_type': args['semester_name']
  //         });
  //       },
  //       dense: true,
  //       tileColor: Colors.grey[800],
  //       title: customText(
  //         txt: stdname,
  //         clr: Colors.white,
  //       ),
  //       subtitle: customText(
  //         txt: stdrollno,
  //         fsize: 14.0,
  //         fweight: FontWeight.w400,
  //         clr: Colors.grey[200],
  //       ),
  //       trailing: customcircleavater(status),
  //     ),
  //   );
  // }
  Widget customlisttile(stdname, stdrollno, status, studentid) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => const subject_percentage(), arguments: {
                        'studentname': stdname,
                        'studentrollno': stdrollno,
                        'studentid': studentid,
                        'session_id': args['session_id'],
                        'semester_type': args['semester_type']
                      });
                    },
                    dense: true,
                    // tileColor: Colors.grey,
                    title: customText(
                      txt: stdname,
                      clr: Colors.white,
                    ),
                    subtitle: customText(
                      txt: stdrollno,
                      fsize: 14.0,
                      fweight: FontWeight.w400,
                      clr: Colors.grey[200],
                    ),
                    trailing: customcircleavater(status),
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: customText(
            txt: "Date: ${args['date']}",
            fsize: 24.0,
            fweight: FontWeight.w500),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : studentslist.isEmpty
              ? Center(
                  child: customText(
                      txt: 'No data available', fsize: 22.0, clr: Colors.white),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                      Container(
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        // height: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.width / 5,

                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: "Subject: ",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.teal,
                                  ),
                                ),
                                TextSpan(
                                  text: "${args['subject_name']} \n",
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Program: ",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.teal,
                                  ),
                                ),
                                TextSpan(
                                  text: "${args['program']} \n",
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.white),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      // NestedScrollView(
                      //     controller: _scrollController,
                      //     headerSliverBuilder: (context, innerBoxIsScrolled) {
                      //       return [
                      //         SliverAppBar(
                      //           elevation: 0,
                      //           // backgroundColor: Colors.teal,
                      //           pinned: true,
                      //           expandedHeight: MediaQuery.of(context).size.height * 0.2,
                      //           collapsedHeight: MediaQuery.of(context).size.height * 0.1,
                      //           centerTitle: false,
                      //           leading: IconButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               icon: const Icon(
                      //                 Icons.arrow_back,
                      //                 color: Colors.white,
                      //                 size: 25.0,
                      //               )),
                      //           title: _isShrink
                      //               ? null
                      //               : Text(
                      //                   "Date: ${args['date']}",
                      //                   // textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     fontSize: 20.0,
                      //                   ),
                      //                 ),
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.only(
                      //             bottomLeft: _isShrink
                      //                 ? const Radius.circular(20.0)
                      //                 : const Radius.circular(0.0),
                      //             bottomRight: _isShrink
                      //                 ? const Radius.circular(20.0)
                      //                 : const Radius.circular(0.0),
                      //             // bottomRight: Radius.circular(40.0)
                      //           )),
                      //           flexibleSpace: FlexibleSpaceBar(
                      //             collapseMode: CollapseMode.parallax,
                      //             title: _isShrink
                      //                 ? SafeArea(
                      //                     child: RichText(
                      //                       textAlign: TextAlign.left,
                      //                       overflow: TextOverflow.visible,
                      //                       softWrap: true,
                      //                       text: TextSpan(children: [
                      //                         const TextSpan(
                      //                           text: "Subject: ",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             color: Colors.teal,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "${args['subject_name']} \n",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             // color: Colors.white,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "Program: ",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             color: Colors.teal,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "${args['program']}",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             //  color: Colors.white
                      //                           ),
                      //                         ),
                      //                       ]),
                      //                     ),
                      //                   )
                      //                 : null,
                      //             background: SafeArea(
                      //               child: Stack(
                      //                 children: <Widget>[
                      //                   Center(
                      //                     child: RichText(
                      //                       textAlign: TextAlign.left,
                      //                       overflow: TextOverflow.visible,
                      //                       softWrap: true,
                      //                       text: TextSpan(children: [
                      //                         const TextSpan(
                      //                           text: "Subject: ",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             color: Colors.teal,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "${args['subject_name']} \n",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             // color: Colors.white,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "Program: ",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             color: Colors.teal,
                      //                           ),
                      //                         ),
                      //                         TextSpan(
                      //                           text: "${args['program']}",
                      //                           style: TextStyle(
                      //                             fontSize: 18.0,
                      //                             //  color: Colors.white
                      //                           ),
                      //                         ),
                      //                       ]),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ];
                      //     },
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return customlisttile(
                                    studentslist[index]['name'],
                                    studentslist[index]['rollno'],
                                    studentslist[index]['status'],
                                    studentslist[index]['studentid'],
                                  );
                                },
                                childCount: studentslist.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
    );
  }
}
