import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom widgets/custom_widgets.dart';

class subject_percentage extends StatefulWidget {
  const subject_percentage({Key? key}) : super(key: key);

  @override
  State<subject_percentage> createState() => _subject_percentageState();
}

class _subject_percentageState extends State<subject_percentage> {
  var args = Get.arguments;
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
      // backgroundColor: Color.fromARGB(255, 20, 69, 106),
    );
  }
   ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    // pickedDate =DateTime.now();
    // _pickedDate();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  Widget customcard(title, cvalue, cpercentage) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 5),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //   ),
      //   title: customText(
      //       txt: "Attandence", fsize: 24.0, fweight: FontWeight.w500),
      // ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Container(
      //       color: Colors.transparent,
      //       alignment: Alignment.topCenter,
      //       // height: MediaQuery.of(context).size.height,
      //       height: MediaQuery.of(context).size.width / 5,

      //       child: Padding(
      //         padding: const EdgeInsets.only(bottom: 10.0),
      //         child: Center(
      //           child: RichText(
      //             textAlign: TextAlign.center,
      //             text: const TextSpan(children: [
      //               TextSpan(
      //                 text: "Student Name: ",
      //                 style: TextStyle(
      //                   fontSize: 17.0,
      //                   color: Colors.teal,
      //                 ),
      //               ),
      //               TextSpan(
      //                 text: "Fizza Chauhdary \n",
      //                 style: TextStyle(
      //                   fontSize: 17.0,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               TextSpan(
      //                 text: "Department:",
      //                 style: TextStyle(
      //                   fontSize: 17.0,
      //                   color: Colors.teal,
      //                 ),
      //               ),
      //               TextSpan(
      //                 text: "  Computer science\n",
      //                 style: TextStyle(fontSize: 17.0, color: Colors.white),
      //               ),
      //             ]),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: CustomScrollView(
      //         slivers: [
      //           SliverList(
      //               delegate: SliverChildBuilderDelegate((context, index) {
      //             return customcard(
      //                 studentsubject[index]['title'],
      //                 studentsubject[index]['cvalue'],
      //                 studentsubject[index]['cpercentage'] + '%');
      //           }, childCount: studentsubject.length))
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.grey[850],
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.13,
              collapsedHeight: MediaQuery.of(context).size.height * 0.1,
              centerTitle: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25.0,
                  )),
              title: _isShrink
                  ? null
                  : Text('Attendence',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: _isShrink
                    ? const Radius.circular(33.0)
                    : const Radius.circular(0.0),
                bottomRight: _isShrink
                    ? const Radius.circular(33.0)
                    : const Radius.circular(0.0),
                // bottomRight: Radius.circular(40.0)
              )),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: _isShrink
                    ? SafeArea(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "Subject: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.teal,
                              ),
                            ),
                            TextSpan(
                              text: "Cloud Computing \n",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "Program: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.teal,
                              ),
                            ),
                            TextSpan(
                              text: "BSCS 8th-R",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ]),
                        ),
                      )
                    : null,
                background: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "\n\n\nSubject: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.teal,
                              ),
                            ),
                            TextSpan(
                              text: "Cloud Computing \n",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "Program:",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.teal,
                              ),
                            ),
                            TextSpan(
                              text: "BSCS 8th-R\n",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: CustomScrollView(
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
    ));
  }
}
