// ignore_for_file: prefer_const_constructors

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Widget customtile(_title, _trailing) {
    return ListTile(
      title: Text(
        _title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
      trailing: Text(
        _trailing,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget CustomDivider() {
    return Divider(
      indent: 10.0,
      endIndent: 10.0,
      color: Colors.grey[800],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: IconButton(
          //     tooltip: 'Delete Profile',
          //     onPressed: () {

          //     },
          //     icon: Icon(
          //       FontAwesomeIcons.userMinus,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              tooltip: 'Edit Profile',
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.userPen,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          const Center(
            child: CircleAvatar(
              radius: 50.0,
              // foregroundImage: CachedNetworkImageProvider(
              //       downloadURL.toString()),
              child: Icon(
                Icons.person,
                size: 80.0,
                color: Colors.white,
              ),
              backgroundColor: Colors.black26,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Teacher',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FirebaseAuth.instance.currentUser!.emailVerified
                      ? Icon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.teal,
                          size: 20.0,
                        )
                      : Text(''),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              'abc@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CustomDivider(),
          customtile('Country', 'pakistan'),
          CustomDivider(),
          customtile('City', 'bhakkar'),
          CustomDivider(),
          customtile('Created on', ''),
          CustomDivider(),
        ],
      ),
    );
  }
}
