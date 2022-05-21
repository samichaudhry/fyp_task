import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';

class SessionStudent extends StatefulWidget {
  const SessionStudent({Key? key}) : super(key: key);

  @override
  State<SessionStudent> createState() => _SessionStudentState();
}

class _SessionStudentState extends State<SessionStudent> {
  bool _isShowDial = false;
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

  Widget customtextformfield(lbltext, isreadonly) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, bottom: 10),
      child: TextFormField(
          readOnly: isreadonly,
          cursorColor: Colors.teal,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: lbltext,
            labelStyle: TextStyle(
              color: Colors.teal,
            ),
            filled: true,
            // enabled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(color: Colors.teal),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialMenuButton(
        isShowSpeedDial: _isShowDial,
        updateSpeedDialStatus: (isShow) {
          this._isShowDial = isShow;
        },
        isMainFABMini: true,
        mainMenuFloatingActionButton: MainMenuFloatingActionButton(
            isExtended: true,
            tooltip: 'Add student',
            mini: false,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () {},
            closeMenuChild: const Icon(Icons.close),
            closeMenuForegroundColor: Colors.white,
            closeMenuBackgroundColor: Colors.red),
        floatingActionButtonWidgetChildren: <FloatingActionButton>[
          FloatingActionButton.extended(
            label: customText(txt: 'upload file'),
            heroTag: 'btn1',
            // mini: true,

            icon: const Icon(FontAwesomeIcons.upload),
            onPressed: () {
              filepicker(
                  filetype: FileType.custom,
                  allowedextensions: ['csv', 'xlsx']);
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          FloatingActionButton.extended(
            // mini: true,
            label: customText(txt: 'add student'),
            icon: const Icon(FontAwesomeIcons.penToSquare),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                          child: customText(
                              txt: "Add Student", fweight: FontWeight.w500)),
                      actions: [
                        customtextformfield('Name', false),
                        customtextformfield('Roll No', false),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('CANCLE')),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('ADD')),
                          ],
                        ),
                      ],
                    );
                  });
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ],
        isSpeedDialFABsMini: true,
        paddingBtwSpeedDialButton: 60.0,
      ),
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
                      leading: const Icon(
                        FontAwesomeIcons.userGraduate,
                        color: Colors.teal,
                      ),
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
                                text: " (${student[index]['semester']})",
                              ),
                            ]),
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