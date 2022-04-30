import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Sheet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
      child: Text("P"),
      value: "P",
    ),
    DropdownMenuItem(
      child: Text("A"),
      value: "A",
    )
  ];
  String date = intl.DateFormat("dd-MMM-yyyy").format(DateTime.now());

  Future<void> updateAttendance(attendance, String id) async {
    await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .update({"attendance": "$attendance"});
  }

  Future<void> updateDate(date, String id) async {
    await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .update({"date": "$date"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'BS Computer Science',
        ),
      ),
      body: Container(
        color: Colors.transparent,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("students")
                .orderBy("rollno", descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var studentData = snapshot.data?.docs;

              if (snapshot.hasError) {
                return const Center(
                  child: Text("Oops An Error Occured"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (studentData!.isEmpty) {
                return const Center(
                  child: Text("No Student Data Available"),
                );
              } else {
                return Column(children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.teal,
                    child: Center(
                        child: Text(
                      "Dated: $date",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                  const ListTile(
                      leading: Text("Sr No"),
                      title: Padding(
                        padding: EdgeInsets.only(left: 80.0),
                        child: Text("Student"),
                      ),
                      trailing: Text("Status")),
                  const Divider(
                    color: Colors.teal,
                    thickness: 2.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: studentData.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot ss = snapshot.data!.docs[index];

                          return ListTile(
                              leading: Text("${index + 1}"),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text(ss["name"]),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text(ss["rollno"]),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: DropdownButton(
                                  value: ss['attendance'],
                                  items: menuItems,
                                  onChanged: (value) {
                                    setState(() {
                                      updateAttendance(value, ss.id);
                                      updateDate(date, ss.id);
                                    });
                                  },
                                ),
                              ));
                        }),
                  ),
                  //   Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Align(
                  //       alignment: Alignment.centerRight,
                  //       child: SizedBox(
                  //         height: 40,
                  //         width: 200,
                  //         child: ElevatedButton(
                  //             onPressed: () {},
                  //             child: const Text("Submit",
                  //                 style: TextStyle(fontSize: 20))),
                  //       ),
                  //     ),
                  //   ),
                  //
                ]);
              }
            }),
      ),
    );
  }
}
