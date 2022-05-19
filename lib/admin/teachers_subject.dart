import 'package:flutter/material.dart';
import 'package:fyp_task/admin/add_subject.dart';
import 'package:fyp_task/admin/subject_info.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class TeacherSubjects extends StatefulWidget {
  const TeacherSubjects({Key? key}) : super(key: key);

  @override
  State<TeacherSubjects> createState() => _TeacherSubjectsState();
}

class _TeacherSubjectsState extends State<TeacherSubjects> {
  List subjects = [
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-SS",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "subjectCode": "CSE-2231",
      "session": "2018-2022",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-SS",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-R",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-SS",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "subjectName": "Cloud Computing",
      "program": "BSCS",
      "semester": "8th-SS",
      "session": "2018-2022",
      "subjectCode": "CSE-2231",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddSubject(), arguments: [
            {"pageTitle": "Add Subject", "buttonText": "Submit"}
          ]);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(
            "Subjects",
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
            "\n\n\nTotal Subjects: ${subjects.length}",
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.grey[800],
                      onTap: () {
                        Get.to(() => const SubjectInfo());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        foregroundImage:
                            NetworkImage(subjects[index]['imgUrl']),
                      ),
                      title: Text(
                        subjects[index]['subjectName'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                            text: subjects[index]['program'],
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "-${subjects[index]['semester']}",
                              ),
                              TextSpan(
                                text: " (${subjects[index]['session']})",
                              ),
                            ]),
                      ),
                      trailing: Text(
                        subjects[index]['subjectCode'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).toList(),
              ),
            );
          },
          childCount: subjects.length,
        )),
      ]),
    );
  }
}
