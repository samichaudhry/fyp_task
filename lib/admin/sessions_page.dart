import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';

class sessionpage extends StatefulWidget {
  const sessionpage({Key? key}) : super(key: key);

  @override
  State<sessionpage> createState() => _sessionpageState();
}

class _sessionpageState extends State<sessionpage> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Session');

  List sessiondata = [
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Computer Science and IT',
      'icon': FontAwesomeIcons.computer
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Biological Science',
      'icon': FontAwesomeIcons.dna
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Chemistry',
      'icon': FontAwesomeIcons.flaskVial
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Physics',
      'icon': FontAwesomeIcons.atom
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Business Administration',
      'icon': FontAwesomeIcons.briefcase
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Commerce',
      'icon': FontAwesomeIcons.cartPlus
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Economics',
      'icon': FontAwesomeIcons.sackDollar
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Education',
      'icon': FontAwesomeIcons.bookOpenReader
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'English',
      'icon': FontAwesomeIcons.arrowDownAZ
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Mathematics',
      'icon': FontAwesomeIcons.calculator
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Psychology',
      'icon': FontAwesomeIcons.brain
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Social Work',
      'icon': FontAwesomeIcons.handshake
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Sociology',
      'icon': FontAwesomeIcons.userClock
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Sports Sciences',
      'icon': FontAwesomeIcons.personRunning
    },
    {
      'title': 'BS-R 2018-2022',
      'subtitle': 'Urdu',
      'icon': FontAwesomeIcons.globe
    },
  ];
  Widget customtextformfield(lbltext, isreadonly) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, bottom: 10),
      child: TextFormField(
          readOnly: isreadonly,
          cursorColor: Colors.teal,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: lbltext,
            labelStyle: const TextStyle(
              color: Colors.teal,
            ),
            filled: true,
            // enabled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          )),
    );
  }

  Widget customcard(title, subtitle, icon) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 2),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 3.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                  title: customText(txt: title, fsize: 17.0),
                  subtitle: customText(txt: subtitle, fsize: 15.0),
                  trailing: Icon(
                    icon,
                    color: Colors.teal,
                    size: 33,
                  )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(
                      Icons.cancel,
                    );
                    customSearchBar = Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(14.0)),
                      height: MediaQuery.of(context).size.height * 0.045,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 2),
                        child: TextField(
                            cursorColor: Colors.teal,
                            decoration: InputDecoration(
                              hintText: 'Search for something',
                              // prefixIcon: Icon(Icons.search),
                              // suffixIcon: Icon(Icons.close),
                              border: InputBorder.none,
                            )),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Session');
                  }
                });
              },
              icon: customIcon,
            ),
          ],
        ),
        //  appBar: AppBar(
        //    backgroundColor: Colors.transparent,
        //    elevation: 0.0,
        //       title: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.grey[800],
        //           borderRadius:  BorderRadius.circular(14.0),
        //         ),
        //         // width: double.infinity,
        //         height: MediaQuery.of(context).size.height * 0.05,
        //         child: TextField(
        //   cursorColor: Colors.teal,
        //   decoration: InputDecoration(
        //     hintText: 'Search for something',
        //         prefixIcon: Icon(Icons.search),
        //         suffixIcon: Icon(Icons.close),
        //      border : InputBorder.none,
        //   )),
        //       ),
        //     ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                        child: customText(
                            txt: "Add Session", fweight: FontWeight.w500)),
                    actions: [
                      customtextformfield('Session', false),
                      customtextformfield('Department', false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('CANCEL')),
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
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Expanded(
                child: Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return customcard(
                              sessiondata[index]['title'],
                              sessiondata[index]['subtitle'],
                              sessiondata[index]['icon']);
                        }, childCount: sessiondata.length),
                      )
                    ],
                  ),
                ),
              )
            ]));
  }
}
