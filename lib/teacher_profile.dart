
import 'package:flutter/material.dart';
import 'package:fyp_task/edit_profile.dart';
import 'package:fyp_task/profile_widget.dart';
class teacherprofile extends StatefulWidget {
  const teacherprofile({Key? key}) : super(key: key);

  @override
  State<teacherprofile> createState() => _teacherprofileState();
}

class _teacherprofileState extends State<teacherprofile> {
  Widget customText(
      {txt,textAlign, fsize = 18.0, clr = Colors.white, fweight = FontWeight.normal}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height:  MediaQuery.of(context).size.height * 0.07,),
          ProfileWidget(
            imagePath: 'assets/images/images (4).png',
            onClicked: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => edit_profile()));
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.019,
          ),
          Column(
            children: [
              customText(txt:'Fizza Chauhdary',fweight: FontWeight.bold,fsize: 24.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              customText(txt:'fizachauhdary783@gmail.com'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(children: [
                  TextSpan(
                    text: "Designation: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.teal,
                    ),
                  ),
                  TextSpan(
                    text: "Lecturer\n",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "Department: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.teal,
                    ),
                  ),
                  TextSpan(
                    text: "Computer Science\n",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ])),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(txt:'About',fsize: 24.0,fweight: FontWeight.bold, ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                customText(
                  txt: 'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
               fsize: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
