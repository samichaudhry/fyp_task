
import 'package:flutter/material.dart';
import 'package:fyp_task/edit_profile_widget.dart';
import 'package:fyp_task/teacher_profile.dart';

class edit_profile extends StatefulWidget {
  const edit_profile({Key? key}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _department = TextEditingController();
  String path = '';
  bool IsSelected = false;
  final maxlength = 5;

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

  Widget customtextformfield(lbltext, _controller, isreadonly, {maxlength}) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 15, bottom: 15),
      child: TextFormField(
          maxLines: maxlength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_val) {
            if (_val!.isEmpty) {
              return 'required';
            }
          },
          readOnly: isreadonly,
          cursorColor: Colors.teal,
          controller: _controller,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: lbltext,
            labelStyle: TextStyle(
              color: Colors.teal,
            ),
            filled: true,
            enabled: true,
            fillColor: Colors.transparent,
             border : OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(color: Colors.teal),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) =>teacherprofile()));
          }),
          title: Center(
              child: customText(
            txt: "Edit Profile",
            fsize: 20.0,
          )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
              ),
            )
          ],
        ),
        body: ListView(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          edit_ProfileWidget(
            imagePath: 'assets/images/images (4).png',
            onClicked: () async {},
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customtextformfield('Full Name', _fullname, false),
                customtextformfield('Designation', _designation, false),
                customtextformfield('Department', _department, false),
                SizedBox(
                    height: maxlength * 30.0,
                    child: customtextformfield('About', _about, false)),
              ],
            ),
          ),
        ]));
  }
}
