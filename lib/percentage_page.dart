import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom widgets/custom_widgets.dart';

class subject_percentage extends StatefulWidget {
  const subject_percentage({Key? key}) : super(key: key);

  @override
  State<subject_percentage> createState() => _subject_percentageState();
}

class _subject_percentageState extends State<subject_percentage> {
  var percentage;
  var barvalue;
  bool isloading = true;
  var args = Get.arguments;
  List subjectdata =[];
  // List studentsubject = [
  //   {'title': 'Cloud computing', 'cvalue': 0.70, 'cpercentage': '70.6'},
  //   {'title': 'Professional practice', 'cvalue': 0.32, 'cpercentage': '32.4'},
  //   {'title': 'Operating system', 'cvalue': 0.20, 'cpercentage': '22.9'},
  //   {'title': 'OOP', 'cvalue': 0.44, 'cpercentage': '48.3'},
  //   {'title': 'Software Engineering', 'cvalue': 0.80, 'cpercentage': '81.7'},
  //   {'title': 'Databse System', 'cvalue': 0.90, 'cpercentage': '90.2'},
  //   {'title': 'Artificial Intelligence', 'cvalue': 0.10, 'cpercentage': '10.1'},
  //   {'title': 'Statistics', 'cvalue': 0.55, 'cpercentage': '55.9'},
  //   {'title': 'Communication skills', 'cvalue': 0.66, 'cpercentage': '66.3'},
  //   {'title': 'Accounting', 'cvalue': 1.00, 'cpercentage': '100'},
  // ];


  Widget customlinearprogres(double barvalue) {
    Color? barcolor;
    if (barvalue <= 0.30) {
      barcolor = Colors.red;
    } else if (barvalue <= 0.70) {
      barcolor = Colors.amber;
    } else if (barvalue <= 1.00) {
      barcolor = Colors.green;
    }
    return LinearProgressIndicator(
      value: barvalue,
      color: barcolor,
    );
  }
  @override
  void initState() {
    super.initState();
    getattendencepercentage();
  }
  Future<void>getattendencepercentage() async{
    await FirebaseFirestore.instance.collectionGroup('subjectstats')
    .where('semester_type', isEqualTo: args['semester_type'])
    .where('session_id', isEqualTo: args['session_id'])
    // .where('statsdata.${args["studentrollno"]}', isEqualTo: args['studentrollno'])
    .get().then((subjects){
      
      for(var subject in subjects.docs){ 
        subjectdata.add({
          'subject_name': subject['subject_name'],
          'total_classes': subject['total_classes'],
          'student_data': subject['statsdata'][args['studentrollno']],
       } );
        print(subject.data());
      }
       }).then((value) {
         setState(() {
           isloading= false;
         });
       });
       }

  Widget customcard(title, value, cpercentage) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 4),
        child: Card(
            // color: Color.fromARGB(255, 50, 54, 79),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 3.0,
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      dense: true,
                      title: customText(txt: title, fsize: 17.0),
                      subtitle:  customlinearprogres(value),
                      trailing: customText(txt: cpercentage, fsize: 14.0)),
                  Center(
                      child: customText(
                          txt: "${subjectdata[0]['student_data']['attendedclasses']} out of ${subjectdata[0]['total_classes']} classes Attended ", fsize: 13.0)
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
            txt: "Attandence", fsize: 24.0, fweight: FontWeight.w500),
      ),
      body: Column(
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
                  textAlign:TextAlign.left,
                  text:  TextSpan(children: [
                   const TextSpan(
                      text: "Name: ",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.teal,
                      ),
                    ),
                    TextSpan(
                      text: "${args['studentname']} \n",
                      style:const TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                   const TextSpan(
                      text: "RollNo: ",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.teal,
                      ),
                    ),
                    TextSpan(
                      text:"${args['studentrollno']} \n",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return customcard(
                      subjectdata[index]['subject_name'],
                     subjectdata[index]['student_data']['percentage']/100,
                       subjectdata[index]['student_data']['percentage'].toString()+ '%');
                }, childCount: subjectdata.length))
              ],
            ),
          )
        ],
      ),
    );
  }
}
