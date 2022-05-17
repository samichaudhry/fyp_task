import 'package:fyp_task/admin/add_teacher.dart';
import 'package:fyp_task/admin/admin_main_page.dart';
import 'package:fyp_task/admin/teacher_info.dart';
import 'package:fyp_task/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List teachers = [
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Lecturer",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Lecturer",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Lecturer",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "http://greenacrescricket.co.uk/wp-content/uploads/2016/10/profile-images.jpg",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Assistant Professor",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Lecturer",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
    {
      "name": "Faheem Ahmad Khalid",
      "desination": "Visiting Lecturer",
      "imgUrl":
          "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddTeacher(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(
            "Teachers",
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
          // automaticallyImplyLeading: false,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(20),
          //     bottomRight: Radius.circular(20),
          //   ),
          // ),
          pinned: true,
          floating: true,
          snap: true,
          expandedHeight: responsiveHW(context, ht: 12),
          collapsedHeight: responsiveHW(context, ht: 10),

          flexibleSpace: FlexibleSpaceBar(
              title: Text(
            "\n\n\nTotal Teachers: ${teachers.length}",
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
                      tileColor: Colors.grey[800],
                      onTap: () {
                        Get.to(() => const TeacherInfo());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        foregroundImage:
                            NetworkImage(teachers[index]['imgUrl']),
                      ),
                      title: Text(
                        teachers[index]['name'],
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        teachers[index]['desination'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ).toList(),
              ),
            );
          },
          childCount: teachers.length,
        )),
      ]),
    );
  }
}
