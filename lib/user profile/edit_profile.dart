import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_task/user profile/profile_widget.dart';
import 'package:fyp_task/user profile/teacher_profile.dart';

import '../custom widgets/custom_widgets.dart';

class edit_profile extends StatefulWidget {
  const edit_profile({Key? key}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _designation = TextEditingController();
  final TextEditingController _department = TextEditingController();
  String path = '';
  bool IsSelected = false;
  final maxlength = 5;
  var imagePath = '';


  Widget customtextformfield(lbltext, _controller,icon, isreadonly, {maxlength}) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 15, bottom: 15),
      child: TextFormField(
          maxLines: maxlength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_val) {
            if (_val!.isEmpty) {
              return 'required';
            }
            return null;
          },
          readOnly: isreadonly,
          cursorColor: Colors.teal,
          controller: _controller,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: lbltext,
            labelStyle: const TextStyle(
              color: Colors.teal,
            ),
            filled: true,
            enabled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const teacherprofile()));
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
              icon: const Icon(
                Icons.check,
              ),
            )
          ],
        ),
        body: ListView(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          ProfileWidget(
              imagePath:
                  'https://e7.pngegg.com/pngimages/8/232/png-clipart-computer-icons-man-avatar-male-login-man-people-monochrome-thumbnail.png',
              onClicked: () {
                filepicker(filetype: FileType.image).then((selectedpath) {
                  if (selectedpath.toString().isNotEmpty) {
                    setState(() {
                      imagePath = selectedpath;
                    });
                  }
                });
              },
              icon: Icons.camera_enhance),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customtextformfield('Full Name', _fullname,Icons.edit ,false,),
                customtextformfield('Designation', _designation, Icons.workspace_premium_outlined,false),
                customtextformfield('Department', _department,FontAwesomeIcons.building ,false),
                SizedBox(
                    height: maxlength * 30.0,
                    child: customtextformfield('About', _about,FontAwesomeIcons.circleInfo,false)),
              ],
            ),
          ),
        ]));
  }
}
