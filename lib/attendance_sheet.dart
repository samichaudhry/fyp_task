import 'package:flutter/material.dart';
import 'package:fyp_task/utils.dart';
import 'custom_widgets.dart';
import 'package:intl/intl.dart' as intl;

class AttendanceSheet extends StatefulWidget {
  const AttendanceSheet({Key? key}) : super(key: key);

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  String date = intl.DateFormat("dd-MMM-yyyy").format(DateTime.now());
  static int totalStudents = 15;
  List<int> selectedStatus = List.generate(
      totalStudents,
      (index) =>
          0); // here we have to mention the strength of students by database in place of 15

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // First App Bar
          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'BS Computer Science',
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  "images/bscs.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // Second App Bar
          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            expandedHeight: responsiveHW(context, ht: 20),
            collapsedHeight: responsiveHW(context, ht: 14),
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                text: TextSpan(
                  text: "Dated: $date",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 10),
                  children: [
                    const TextSpan(
                      text:
                          "\nMobile Application Development (BSCS-8th, 2018-2022)",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    TextSpan(
                      text: "\n\nTotal Students: $totalStudents",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
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
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButton("Show Percentage", () {}, context),
                      customButton("View Report", () {}, context)
                    ],
                  ),
                ),
                const ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        "Students",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 70.0),
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
                  title: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text("Student Number $index"),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text("RollNO $index"),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                                visualDensity: VisualDensity.comfortable,
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text("P"),
                                value: 1,
                                groupValue: selectedStatus[index],
                                onChanged: (int? val) {
                                  setState(() {
                                    selectedStatus[index] = val!;
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
                                groupValue: selectedStatus[index],
                                onChanged: (int? val) {
                                  setState(() {
                                    selectedStatus[index] = val!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            childCount: 15,
          )),
          // Submit Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 28.0, bottom: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: customButton("Submit", () {}, context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
