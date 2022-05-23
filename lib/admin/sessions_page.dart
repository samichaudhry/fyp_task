import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/admin/session_student.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:get/get.dart';

import '../utils.dart';

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

  String? dropdownvalue;
  var selecteddepartment = '';
  var selectedprogram = '';
  List<String> department = [
    'Computer Science and IT',
    'Biological Science',
    'Chemistry',
    'Physics',
    'Business Administration',
    'Commerce',
    'Economics',
    'Education',
    'English',
    'Mathematics',
    'Psychology',
    'Social Work',
    'Sociology',
    'Sports Sciences',
    'Urdu'
  ];
  static Map<String, List<String>> programs = {
    'Computer Science and IT': <String>[
      "BS Computer Science",
      "BS Information Technology",
      "MIT",
    ],
    'Biological Science': <String>[
      "BS Botonay",
    ],
    'Chemistry': <String>[
      "BS Chemistry",
      "Msc Chemistry",
    ],
    'Physics': <String>[
      "BS Physics",
      "Msc Physics",
    ],
    'Business Administration': <String>[
      "BBA",
      "B.com",
    ],
    'Economics': <String>[
      "BS Economics",
    ],
    'Education': <String>[
      "BS Education",
      "B.ED",
    ],
    'English': <String>[
      "BS English",
      "MA English",
    ],
    'Mathematics': <String>[
      "BS Mathematics",
      "Msc Mathematics",
    ],
    'Psychology': <String>[
      "BS Psychology",
    ],
    'Social Work': <String>[
      "BS Social Work",
    ],
    'Sociology': <String>[
      "BS Sociology",
    ],
    'Sports Sciences': <String>["BS Sports Sciences", "MA Sports Sciences"],
    'Urdu': <String>['BS Urdu', 'MA Urdu'],
  };
  // List<String> programs2years = [

  // ];

  //Session's lists
  List<String> sessions4years = [
    '2018-2022',
    '2019-2023',
    '2020-2024',
    '2021-2025',
    '2022-2026',
    '2023-2027',
    '2024-2028',
    '2025-2029',
    '2026-2030',
    '2027-2031',
    '2028-2032',
    '2029-2033',
    '2030-2034',
    '2031-2035',
    '2032-2036',
    '2033-2037',
    '2034-2038',
    '2035-2039',
    '2036-2040',
    '2037-2041',
    '2038-2042',
  ];
  List<String> sessions2years = [
    '2018-2020',
    '2019-2021',
    '2020-2022',
    '2021-2023',
    '2022-2024',
    '2023-2025',
    '2024-2026',
    '2025-2027',
    '2026-2028',
    '2027-2029',
    '2028-2030',
    '2029-2031',
    '2030-2032',
    '2031-2033',
    '2032-2034',
    '2033-2035',
    '2034-2036',
    '2035-2037',
    '2036-2038',
    '2037-2039',
    '2038-2040',
  ];

  List<String> session = [
    // '2 years programs',
    '2018-2020',
    '2019-2021',
    '2020-2022',
    '2021-2023',
    '2022-2024',
    '2023-2025',
    '2024-2026',
    '2025-2027',
    '2026-2028',
    '2027-2029',
    '2028-2030',
    '2029-2031',
    '2030-2032',
    '2031-2033',
    '2032-2034',
    '2033-2035',
    '2034-2036',
    '2035-2037',
    '2036-2038',
    // '4 years programs',
    '2018-2022',
    '2019-2023',
    '2020-2024',
    '2021-2025',
    '2022-2026',
    '2023-2027',
    '2024-2028',
    '2025-2029',
    '2026-2030',
    '2027-2031',
    '2028-2032',
    '2029-2033',
    '2030-2034',
    '2031-2035',
    '2032-2036',
    '2033-2037',
    '2034-2038'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: customFAB(
        text: customText(txt: 'Session', clr: Colors.white),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        ontap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, statesetter) {
                  return AlertDialog(
                    title: Center(
                        child: customText(
                            txt: "Add Session", fweight: FontWeight.w500)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19, right: 19, bottom: 10),
                        child: DropdownButtonFormField(
                          items: department
                              .map((String value) => DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                              .toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.teal),
                            ),
                            labelText: 'Department',
                            prefixIcon:const Icon(FontAwesomeIcons.building),
                          ),
                          onChanged: (String? newValue) {
                            statesetter(() {
                              // dropdownvalue = newValue!;
                              selectedprogram = '';
                              selecteddepartment = newValue!;
                              dropdownvalue = '';
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19, right: 19, bottom: 10),
                        child: DropdownButtonFormField(
                          items: programs[selecteddepartment]
                              ?.map((value) => DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                              .toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.teal),
                            ),
                            labelText: 'Program',
                             prefixIcon:const Icon(FontAwesomeIcons.barsProgress
                             ),
                          ),
                         
                          
                          onChanged: (String? newValue) {
                            statesetter(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19, right: 19, bottom: 10),
                        child: DropdownButtonFormField(
                          items: session
                              .map((String value) => DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                              .toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.teal),
                            ),
                            labelText: 'Session',
                            prefixIcon:const Icon(FontAwesomeIcons.calendar),
                          ),
                          onChanged: (String? newValue) {
                            statesetter(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('CANCLE')),
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
              });
        },
        clr: Colors.teal,
        // child: Icon(
        //   Icons.add,
        //   color: Colors.white,
        // ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
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
                      customSearchBar = SizedBox(
                        // decoration: BoxDecoration(
                        //     // color: Colors.grey[800],
                        //     borderRadius: BorderRadius.circular(14.0)),
                        height: MediaQuery.of(context).size.height * 0.045,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 2),
                          child: TextField(
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                hintText: 'Search Session',
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
              "\n\n\nTotal Session: ${sessiondata.length}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey[400]),
            )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 19, right: 19, top: 13),
                child: Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        tileColor: Colors.grey[800],
                        onTap: () {
                          Get.to(() => const SessionStudent());
                        },
                        title: customText(
                          txt: sessiondata[index]['title'],
                          fsize: 17.0,
                          fweight: FontWeight.w700,
                        ),
                        subtitle: customText(
                          txt: sessiondata[index]['subtitle'],
                          fsize: 16.0,
                          fweight: FontWeight.w600,
                        ),
                        trailing: Icon(
                          sessiondata[index]['icon'],
                          color: Colors.teal,
                          size: 33,
                        ),
                      ),
                    ],
                  ).toList(),
                ),
              );
            }, childCount: sessiondata.length),
          )
        ],
      ),
    );
  }
}
