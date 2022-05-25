// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import 'custom widgets/custom_widgets.dart';

class class_attendence extends StatefulWidget {
  const class_attendence({Key? key}) : super(key: key);

  @override
  State<class_attendence> createState() => _class_attendence();
}

class _class_attendence extends State<class_attendence> {
  List studentdata = [
    {'name': 'Rustum shakeel', 'roll_no': 'BCSF18BM001','status':'A'},
    {'name': 'Aamna Malik', 'roll_no': 'BCSF18BM002','status':'A'},
    {'name': 'Sami Ullah', 'roll_no': 'BCSF18BM003','status':'P'},
    {'name': 'Usman feyaz', 'roll_no': 'BCSF18BM004','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Alii', 'roll_no': 'BCSF18BM006','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'P'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
    {'name': 'Babar Ali', 'roll_no': 'BCSF18BM005','status':'A'},
  ];
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
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }


  Widget customcircleavater(value) {
    Color? circlecolor;
    if (value == 'P') {
      circlecolor = Colors.green;
    } else if (value == 'A') {
      circlecolor = Colors.red;
    }
    else{
      circlecolor = Colors.black;
    }
    return CircleAvatar(
        backgroundColor: circlecolor,
        radius: 16.0,
        child: customText(
          txt: value,
        ));
  }

  Widget customlisttile(stdname, stdrollno,status) {
    return ListTile(
      dense: true,
      tileColor: Colors.white70,
      title: customText(
        txt: stdname,
      ),
      subtitle: customText(txt: stdrollno, fsize: 13.0),
      trailing: customcircleavater(status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.teal,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.40,
              collapsedHeight: MediaQuery.of(context).size.height * 0.10,
              centerTitle: false,
              // actions: [
              //   Center(
              //       child: DottedCircularProgressIndicatorFb(
              //     size: 30,
              //     numDots: 9,
              //     dotSize: 3,
              //     defaultDotColor: Colors.blue,
              //     currentDotColor: Colors.orange,
              //     secondsPerRotation: 1,
              //   ))
              // ],
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25.0,
                  )),
              title: _isShrink
                  ? null
                  : const Text(
                      "Date: 28-04-2022",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: _isShrink
                    ? const Radius.circular(0.0)
                    : const Radius.circular(40.0),
                bottomRight: _isShrink
                    ? const Radius.circular(40.0)
                    : const Radius.circular(0.0),
                // bottomRight: Radius.circular(40.0)
              )),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: _isShrink
                    ? SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                "Subject: Cloud Computing",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Class: BSCS 8th",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
                background: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              "Subject: Cloud Computing",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Class: BSCS 8th",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return customlisttile(studentdata[index]['name'],
                      studentdata[index]['roll_no'],studentdata[index]['status']);
                },
                childCount: studentdata.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
