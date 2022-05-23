import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/custom_formfield.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var imgPath = '';
  final TextEditingController _subjName = TextEditingController();
  final TextEditingController _subjCode = TextEditingController();
  // final TextEditingController _program = TextEditingController();
  // final TextEditingController _semester = TextEditingController();
  // final TextEditingController _session = TextEditingController();
  var editSubjectArgument = Get.arguments;

  String? selectedProgram;
  String? selectedSemester;
  String? selectedSession;
  String? selectedYear;
  String? selectedFallOrSpring;

  // Semester Type
  List<String> fallORSpring = ['Fall', 'Spring'];
  List<String> years = [
    "2018",
    "2019",
    "2020",
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',
  ];
  //Program's lists
  List<String> programs4years = [
    "BS Computer Science",
    "BS Information Technology",
    "BS Chemistry",
    "BS Physics",
    "BS English",
    "BS Education",
    "BS Economics",
    "BBA",
    "B.com",
    "BS Sociology",
    "BS Social Work",
    "BS Botonay",
    "BS Psychology",
    "BS Sports Sciences"
  ];
  List<String> programs2years = [
    "MIT",
    "Msc Chemistry",
    "Msc Physics",
    "MA English",
    "B.ED",
    "MA Sports Sciences"
  ];

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
  // semester's lists
  List<String> semester2years = ['1st', '2nd', '3rd', '4th'];
  List<String> semester4years = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th'
  ];

  // Custom Sized Box
  SizedBox customSizedBox({height = 2}) => SizedBox(
        height: responsiveHW(context, ht: height),
      );

  // custom dropdown buttons field

  Widget customDropDownFormField(
      fieldTitle, dropDownValue, List<String> listOfItems, onChangedFunc) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: responsiveHW(context, wd: 6)!.toDouble()),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: fieldTitle,
            focusColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          validator: (value) => value == null ? 'Required*' : null,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
          hint: Text(
            'Select $fieldTitle',
          ),
          value: dropDownValue,
          items: listOfItems.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChangedFunc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              centerTitle: true,
              pinned: true,
              snap: true,
              floating: true,
              elevation: 0.0,
              title: customText(
                txt: editSubjectArgument[0]["pageTitle"].toString(),
                clr: Colors.white,
                fsize: 20.0,
                fweight: FontWeight.w500,
              ),
              expandedHeight: responsiveHW(context, ht: 8),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: responsiveHW(context, wd: 100),
                height: responsiveHW(context, ht: 23),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    customSizedBox(height: 1),
                    GestureDetector(
                        onTap: () {
                          filepicker(filetype: FileType.image)
                              .then((selectedpath) {
                            if (selectedpath.toString().isNotEmpty) {
                              setState(() {
                                imgPath = selectedpath;
                              });
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          foregroundImage: FileImage(File(imgPath)),
                          child: const Icon(
                            Icons.person,
                            size: 80.0,
                            color: Colors.white,
                          ),
                        )),
                    customSizedBox(height: 1),
                    Text(
                      "Select Subject Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: responsiveHW(context, ht: 2)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(
                bottom: responsiveHW(context, ht: 3)!.toDouble(),
              )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              customTextField(
                  "Subject Name", Icons.edit, false, null, _subjName, (value) {
                if (value!.isEmpty) {
                  return "Please Enter Subject Name";
                }
              }, (value) {
                _subjName.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customTextField(
                  "Subject Code", Icons.code, false, null, _subjCode, (value) {
                if (value!.isEmpty) {
                  return "Subject Code Required*";
                }
              }, (value) {
                _subjCode.text = value!;
              }, responsiveHW(context, wd: 100),
                  responsiveHW(context, ht: 100)),
              customSizedBox(),
              customDropDownFormField(
                  "Program", selectedProgram, programs4years + programs2years,
                  (value) {
                setState(() {
                  selectedProgram = value;
                  selectedSession = null;
                  selectedSemester = null;
                });
              }),
              customSizedBox(),
              customDropDownFormField(
                  "Session",
                  selectedSession,
                  programs4years.contains(selectedProgram)
                      ? sessions4years
                      : sessions2years, (value) {
                setState(() {
                  selectedSession = value;
                });
              }),
              customSizedBox(),
              customDropDownFormField(
                  "Semester",
                  selectedSemester,
                  programs4years.contains(selectedProgram)
                      ? semester4years
                      : semester2years, (value) {
                setState(() {
                  selectedSemester = value;
                });
              }),
              customSizedBox(),
              customDropDownFormField(
                  "Fall / Spring", selectedFallOrSpring, fallORSpring, (value) {
                setState(() {
                  selectedFallOrSpring = value;
                });
              }),
              customSizedBox(),
              customDropDownFormField("Year", selectedYear, years, (value) {
                setState(() {
                  selectedYear = value;
                });
              }),
              customSizedBox(height: 3),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsiveHW(context, wd: 6)!.toDouble()),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color(0xff009688)),
                    height: responsiveHW(context, ht: 6),
                    child: TextButton(
                      child: Text(
                        editSubjectArgument[0]['buttonText'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: responsiveHW(context, ht: 3)),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ))
            ]))
          ],
        ),
      ),
    );
  }
}
