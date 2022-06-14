import 'package:flutter/material.dart';

class subject_percentage extends StatefulWidget {
  const subject_percentage({Key? key}) : super(key: key);

  @override
  State<subject_percentage> createState() => _subject_percentageState();
}

class _subject_percentageState extends State<subject_percentage> {
  List studentsubject = [
    {'title': 'Cloud computing', 'cvalue': 0.70, 'cpercentage': '70.6'},
    {'title': 'Professional practice', 'cvalue': 0.32, 'cpercentage': '32.4'},
    {'title': 'Operating system', 'cvalue': 0.20, 'cpercentage': '22.9'},
    {'title': 'OOP', 'cvalue': 0.44, 'cpercentage': '48.3'},
    {'title': 'Software Engineering', 'cvalue': 0.80, 'cpercentage': '81.7'},
    {'title': 'Databse System', 'cvalue': 0.90, 'cpercentage': '90.2'},
    {'title': 'Artificial Intelligence', 'cvalue': 0.10, 'cpercentage': '10.1'},
    {'title': 'Statistics', 'cvalue': 0.55, 'cpercentage': '55.9'},
    {'title': 'Communication skills', 'cvalue': 0.66, 'cpercentage': '66.3'},
    {'title': 'Accounting', 'cvalue': 1.00, 'cpercentage': '100'},
  ];

  Widget customlinearprogres(double bvalue) {
    Color? barcolor;
    if (bvalue <= 0.30) {
      barcolor = Colors.red;
    } else if (bvalue <= 0.70) {
      barcolor = Colors.amber;
    } else if (bvalue <= 1.00) {
      barcolor = Colors.green;
    }
    return LinearProgressIndicator(
      value: bvalue,
      color: barcolor,
      backgroundColor: const Color.fromARGB(255, 20, 69, 106),
    );
  }

  Widget customText(
      {txt,
      textAlign,
      fsize = 18.0,
      clr = Colors.white,
      fweight = FontWeight.normal}) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fsize,
        color: clr,
        fontWeight: fweight,
      ),
    );
  }

  Widget customcard(title, cvalue, cpercentage) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 5),
        child: Card(
            color: const Color.fromARGB(255, 50, 54, 79),
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
                      subtitle: customlinearprogres(cvalue),
                      trailing: customText(txt: cpercentage, fsize: 14.0)),
                  Center(
                      child: customText(
                          txt: "4 out of 6 classes Attended ", fsize: 13.0))
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 69, 106),
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
            color: const Color.fromARGB(255, 20, 69, 106),
            alignment: Alignment.topCenter,
            // height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.width / 5,

            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "Student Name: ",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.teal,
                      ),
                    ),
                    TextSpan(
                      text: "Fizza Chauhdary \n",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "Department:",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.teal,
                      ),
                    ),
                    TextSpan(
                      text: "  Computer science\n",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 20, 69, 106),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return customcard(
                        studentsubject[index]['title'],
                        studentsubject[index]['cvalue'],
                        studentsubject[index]['cpercentage'] + '%');
                  }, childCount: studentsubject.length))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
