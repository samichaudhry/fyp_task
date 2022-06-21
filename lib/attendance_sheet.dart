import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_toast.dart';
import 'package:fyp_task/reportpage.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'custom widgets/custom_widgets.dart';
import 'package:intl/intl.dart' as intl;

class AttendanceSheet extends StatefulWidget {
  const AttendanceSheet({Key? key}) : super(key: key);

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  var args = Get.arguments;
  String date = intl.DateFormat("dd-MMM-yyyy").format(DateTime.now());
  var totalStudents = 0;
  List<int>?
      selectedStatus; // here we have to mention the strength of students by database in place of 15
  List studentslist = [];
  @override
  void initState() {
    super.initState();

    studentsdata();
  }

  Future studentsdata() async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(args['session_id'])
        .collection('sessionstudents')
        .orderBy('studentrollno', descending: false)
        .get()
        .then((QuerySnapshot students) {
      totalStudents = students.docs.length; // uncomment this for total students
      for (var student in students.docs) {
        print(student.data());
        studentslist.add({
          'status': 1,
          'data': student.data(),
          'id': student.id.toString(),
        });
      }
    });
    setState(() {});
  }

  double percentagefinder({totaclasses = 0, attendedclasses = 0}) {
    if (totaclasses == 0) {
      return 0.0;
    } else {
      return (attendedclasses / totaclasses * 100);
    }
  }

  Future saveattendance() async {
// print(percentagefinder(totaclasses: 5, attendedclasses: 3).toPrecision(1));
    customdialogcircularprogressindicator('Saving... ');
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    final String formatted = formatter.format(now);
    print(formatted); // 2013-04-20
    List studentsattendance = [];
    var studentsstatsdata = {};
    for (var studentdata in studentslist) {
      studentsstatsdata[studentdata['data']['studentrollno']] = {
        'attendedclasses': 0,
        'percentage': 0.0,
        'name': studentdata['data']['studentname'],
        'rollno': studentdata['data']['studentrollno'],
        'studentid': studentdata['id'],
      };
      studentsattendance.add({
        'name': studentdata['data']['studentname'],
        'rollno': studentdata['data']['studentrollno'],
        'status': studentdata['status'] == 1 ? 'P' : 'A',
        'studentid': studentdata['id'],
      });
    }
    await FirebaseFirestore.instance
        .collection('attendance')
        .doc(args['subject_id'])
        .collection('attendancedata')
        .where('attendancedate', isEqualTo: formatted)
        .get()
        .then((QuerySnapshot record) async {
      if (record.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection('attendance')
            .doc(args['subject_id'])
            .collection('attendancedata')
            .doc()
            .set({
          'attendancerecord': studentsattendance,
          'session_id': '${args['session_id']}',
          'semester_type': '${args["semester_type"]}',
          'attendancedate': formatted,
          'subject_name': '${args['subject_name']}',
          'subject_code': '${args['subject_code']}',
        }, SetOptions(merge: true)).then((value) async {
          var totalclasses = 1;
          await FirebaseFirestore.instance
              .collection('attendancestats')
              .doc(args['subject_id'])
              .collection('subjectstats')
              .doc(args['subject_name'])
              .get()
              .then((ds) {
            if (ds.exists) {
              if (ds['statsdata'] != null) {
                studentsstatsdata = ds['statsdata'];
              }
              if (ds['total_classes'] != null) {
                totalclasses = ds['total_classes'] + 1;
              }
            }
          });
          for (var studentdata in studentslist) {
            var attcls = studentsstatsdata[studentdata['data']['studentrollno']]
                ['attendedclasses'];
            studentsstatsdata[studentdata['data']['studentrollno']]
                    ['attendedclasses'] =
                studentdata['status'] == 1 ? attcls + 1 : attcls;
            attcls = studentsstatsdata[studentdata['data']['studentrollno']]
                ['attendedclasses'];
            studentsstatsdata[studentdata['data']['studentrollno']]
                ['percentage'] = percentagefinder(
                    totaclasses: totalclasses, attendedclasses: attcls)
                .toPrecision(1);
            //  {
            //   'attendedclasses': 0,
            //   'percentage': 0.0,
            //   'name': studentdata['data']['studentname'],
            //   'rollno': studentdata['data']['studentrollno'],
            //   'status': studentdata['status'] == 1 ? 'P' : 'A',
            //   'studentid': studentdata['id'],
            // };
          }
          await FirebaseFirestore.instance
              .collection('attendancestats')
              .doc(args['subject_id'])
              .collection('subjectstats')
              .doc(args['subject_name'])
              .set({
            'session_id': '${args['session_id']}',
            'semester_type': '${args["semester_type"]}',
            'subject_name': '${args['subject_name']}',
            'subject_code': '${args['subject_code']}',
            'total_classes': FieldValue.increment(1),
            'statsdata': studentsstatsdata,
          }, SetOptions(merge: true)).then((value) async {
            var presentStu = [];
            var absentStu = [];
            await FirebaseFirestore.instance
                .collection('attendance')
                .doc(args['subject_id'])
                .collection('attendancedata')
                .where('attendancedate', isEqualTo: formatted.toString())
                .where('session_id', isEqualTo: args['session_id'])
                .get()
                .then((QuerySnapshot students) {
              for (var student in students.docs) {
                List data = student['attendancerecord'];
                for (var std in data) {
                  if (std['status'] == 'P') {
                    presentStu.add({
                      'status': std['status'],
                    });
                  } else {
                    absentStu.add({
                      'status': std['status'],
                    });
                  }
                }
              }
            });
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Today's Attendance Stats",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.teal,
                                        fontSize: responsiveHW(context, ht: 3)),
                                  ),
                                ),
                                SizedBox(
                                  height: responsiveHW(context, ht: 3),
                                ),
                                Text(
                                    "Percentage of Present Students: ${((presentStu.length / totalStudents) * 100).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize:
                                            responsiveHW(context, ht: 2))),
                                SizedBox(
                                  height: responsiveHW(context, ht: 1),
                                ),
                                Text(
                                    "Percentage of Absent Students: ${((absentStu.length / totalStudents) * 100).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize:
                                            responsiveHW(context, ht: 2))),
                                SizedBox(
                                  height: responsiveHW(context, ht: 2),
                                ),
                                Center(
                                  child: customButton("Close", () {
                                    Navigator.pop(context);
                                  }, context, responsiveHW(context, wd: 10)),
                                )
                              ])));
                });

            // rawsnackbar('Attendance Submitted successfully',
            //     icon: const Icon(
            //       Icons.check_box,
            //       color: Colors.green,
            //       size: 25.0,
            //     ));
          });
        });
      } else {
        Navigator.pop(context);
        rawsnackbar('Attendance already found..!!!',
           icon: const Icon(
              Icons.warning,
              color: Colors.red,
              size: 25.0,
            ));
      }
    });
  }

  // Future attendancestats() async {

  // }

  _pickedDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                  primary: Colors.grey,
                  primaryContainer: Colors.white,
                  onPrimary: Colors.white,
                  secondary: Colors.grey,
                  secondaryContainer: Colors.grey,
                  surface: Colors.black12),
            ),
            child: child!);
      },
    ).then((value) {
      // if(value == null){
      //   // print('not selected');

      // }
      if (value != null) {
        //  setState(() {
        // pickedDate = value;
        Get.to(() => const ReportPage(), arguments: {
          'date': DateFormat('dd-MMM-yyyy').format(value),
          'subject_name': '${args['subject_name']}',
          'subject_code': '${args['subject_code']}',
          'program': '${args['program']}',
          'semester': '${args['semester']}',
          'semester_type': '${args['semester_type']}',
          'subject_id': '${args['subject_id']}',
          'session_id': '${args['session_id']}',
        });
        // print(value.toLocal());
        // });
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: totalStudents == 0
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : CustomScrollView(
              slivers: [
                // First App Bar
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: responsiveHW(context, ht: 25),
                  flexibleSpace: FlexibleSpaceBar(
                    // title: customText(
                    //   txt: 'BS Computer Science',
                    //   clr: Colors.black,
                    // ),
                    background: args['imgUrl'] == 'null' || args['imgUrl'] == ''
                        ? Image.asset(
                            "assets/images/bscs.png",
                            fit: BoxFit.fill,
                          )
                        : Image.network(args['imgUrl']),
                  ),
                ),
                // Second App Bar
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  pinned: true,
                  floating: true,
                  snap: true,
                  expandedHeight: responsiveHW(context, ht: 22),
                  collapsedHeight: responsiveHW(context, ht: 14),
                  flexibleSpace: FlexibleSpaceBar(
                    title: RichText(
                      text: TextSpan(
                        text: "Dated: $date",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10),
                        children: [
                          TextSpan(
                            text:
                                "\n${args['subject_name']} (${args['program']}, ${args['semester']} Semester)",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          TextSpan(
                            text: "\n\nTotal Students: $totalStudents",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.grey[400]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Button's tile
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 15, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // customButton("Show Percentage", () {
                            //   // Navigator.pushReplacement(
                            //   //     context,
                            //   //     MaterialPageRoute(
                            //   //         builder: (context) => const LoginPage()));
                            // }, context, 120),
                            const SizedBox(
                              height: 5,
                            ),
                            customButton("View Report", () {
                              _pickedDate();
                            }, context, 120)
                          ],
                        ),
                      ),
                      const ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Students",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 40.0),
                            child: Text(
                              "Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          )),
                    ],
                  ),
                ),
                // Student's Tile
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                        title: Text(
                            "${studentslist[index]['data']['studentname']}"),
                        subtitle: Text(
                            "${studentslist[index]['data']['studentrollno']}"),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                    visualDensity: VisualDensity.comfortable,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: const Text("P"),
                                    value: 1,
                                    groupValue: studentslist[index]['status'],
                                    onChanged: (val) {
                                      setState(() {
                                        studentslist[index]['status'] = val;
                                        print(val);
                                        print(studentslist[index]['status']);
                                        print(studentslist[index]['data']
                                            ['studentname']);
                                      });
                                    }),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: RadioListTile(
                                    visualDensity: VisualDensity.comfortable,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: const Text("A"),
                                    value: 2,
                                    groupValue: studentslist[index]['status'],
                                    onChanged: (val) {
                                      setState(() {
                                        studentslist[index]['status'] = val;
                                        print(val);
                                        print(studentslist[index]['status']);
                                        print(studentslist[index]['data']
                                            ['studentname']);
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ));
                  },
                  childCount: studentslist.length,
                )),
                // Submit Button
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 15, left: 15, top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child:
                          customButton("Submit", saveattendance, context, 120),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
