import 'package:flutter/material.dart';
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
  String date = intl.DateFormat("dd-MMM-yyyy").format(DateTime.now());
  static int totalStudents = 15;
  List<int> selectedStatus = List.generate(
      totalStudents,
      (index) =>
          1); // here we have to mention the strength of students by database in place of 15

  _pickedDate()async{
    DateTime? date = await showDatePicker(context: context,  
    initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2025),
    
    builder: (context, child ){
      return Theme(data: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(primary:Colors.grey,
        primaryContainer: Colors.white,
         onPrimary: Colors.white,
         secondary:Colors.grey, 
         secondaryContainer: Colors.grey,
          surface: Colors.black12 
        ),
      ), child:child!);
        },
    ).then((value){
      // if(value == null){
      //   // print('not selected');

      // }
 if(value != null){
      //  setState(() {
      // pickedDate = value;
      Get.to(
        ()=> const ReportPage(),
        arguments: {
          'date' : DateFormat('dd-MMM-yyyy').format(value),
        }
      );
      // print(value.toLocal());
    // });
    }
    });
   
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              background: Image.asset(
                "assets/images/bscs.png",
                fit: BoxFit.fill,
              ),
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
                    const TextSpan(
                      text:
                          "\nMobile Application Development (BSCS-8th, 2018-2022)",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 15, left: 15),
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
                  title: Text("Student Number $index"),
                  subtitle: Text("RollNO $index"),
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
                  ));
            },
            childCount: 15,
          )),
          // Submit Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, right: 15, left: 15, top: 10),
              child: Align(
                alignment: Alignment.center,
                child: customButton("Submit", () {}, context, 120),
              ),
            ),
          )
        ],
      ),
    );
  }
}
