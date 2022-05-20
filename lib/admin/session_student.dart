import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';

class SessionStudent extends StatefulWidget {
  const SessionStudent({Key? key}) : super(key: key);

  @override
  State<SessionStudent> createState() => _SessionStudentState();
}

class _SessionStudentState extends State<SessionStudent> {
  List student = [
    {
      "studentName": "Rustum shakeel",
      "rollno": "BCSF18BM001",
      "semester": "8th-R",
    },
    {
      "studentName": "Amna malik",
      "rollno": "BCSF18BM002",
      "semester": "8th-R",
    },
    {
      "studentName": "sami ullah",
      "rollno": "BCSF18BM003",
      "semester": "8th-R",
    },
    {
      "studentName": "Usman feyaz",
      "rollno": "BCSF18BM004",
      "semester": "8th-R",
    },
    {
      "studentName": "Babar Ali",
      "rollno": "BCSF18BM005",
      "semester": "8th-R",
    },
    {
      "studentName": "Aqsa zafar",
      "rollno": "BCSF18BM006",
      "semester": "8th-R",
    },
    {
      "studentName": "Ahad raza",
      "rollno": "BCSF18BM007",
      "semester": "8th-R",
    },
    {
      "studentName": "Zulfiqar Ali",
      "rollno": "BCSF18BM23",
      "semester": "8th-R",
    },
    {
      "studentName": "Fizza Chauhdary",
      "rollno": "BCSF18BM23",
      "semester": "8th-R",
    },
    {
      "studentName": "Fizza Chauhdary",
      "rollno": "BCSF18BM23",
      "semester": "8th-R",
    },
    {
      "studentName": "Fizza Chauhdary",
      "rollno": "BCSF18BM23",
      "semester": "8th-R",
    },
    {
      "studentName": "Fizza Chauhdary",
      "rollno": "BCSF18BM23",
      "semester": "8th-R",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: customFAB(
          clr: Colors.teal,
          ontap: () {
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          text:customText(txt: 'Student', clr: Colors.white)),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(
            "Students",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
          expandedHeight: responsiveHW(context, ht: 12),
          collapsedHeight: responsiveHW(context, ht: 11),
          flexibleSpace: FlexibleSpaceBar(
              title: Text(
            "\n\n\nTotal Student: ${student.length}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[400]),
          )),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 19, right: 19, top: 13),
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.grey[800],
                      onTap: () {
                        // Get.to(() => const TeacherInfo());
                      },
                      leading:const Icon(FontAwesomeIcons.userGraduate,color: Colors.teal,),
                      title: Text(
                        student[index]['studentName'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                            text: student[index]['rollno'],
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text:  " (${student[index]['semester']})",
                              ),
                            ]
                            ),
                      ),
                    ),
                  ],
                ).toList(),
              ),
            );
          },
          childCount: student.length,
        )),
      ]),
    );
  }
}
