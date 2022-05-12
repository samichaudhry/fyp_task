import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:fyp_task/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 30.0,
            margin: EdgeInsets.symmetric(
                vertical: 80.0,
                horizontal: Responsive.isMobile(context) ? 50 : 300.0),
            color: Colors.teal.withOpacity(0.4),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40.0,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
                // const Padding(padding: EdgeInsets.all(8.0)),
                Center(child: customText(txt: 'Teacher')),
                Center(child: customText(txt: 'abc@gmail.com')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.red.withOpacity(0.8)),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    label: customText(txt: 'Logout', clr: Colors.white),
                  ),
                ),
                // customText(txt: 'Hello'),
                // customText(txt: 'Hello'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
