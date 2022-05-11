import 'package:flutter/material.dart';
import 'package:fyp_task/custom_widgets.dart';
import 'package:fyp_task/nav_menu.dart';
import 'package:fyp_task/utils.dart';
import 'package:get/get.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(20),
              //     bottomRight: Radius.circular(20),
              //   ),
              // ),
              expandedHeight: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.height * 0.25
                  : MediaQuery.of(context).size.height * 0.45,
              flexibleSpace: FlexibleSpaceBar(
                // title: const Text(
                //   'Subjects',
                // ),
                background: ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //   bottomLeft: Radius.circular(10),
                  //   bottomRight: Radius.circular(10),
                  // ),
                  child: Image.asset(
                    "images/bscs.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(
                top: 5.0,
              )),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black.withOpacity(0.7),
              title: customText(
                txt: 'Subjects',
                clr: Colors.white,
                fsize: 20.0,
                fweight: FontWeight.w500,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ), // Your icon here
                    label: customText(
                      txt: 'Logout',
                      clr: Colors.white,
                    ), // Your text here
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(
                bottom: 2.5,
              )),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => HomeWidget(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        // Colors
                        // .primaries[Random().nextInt(Colors.primaries.length)]
                        // .withOpacity(0.4)
                        color: Colors.teal.withOpacity(0.6),
                      ),
                      margin: const EdgeInsets.all(3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                txt: 'Cloud\nComputing\nCSE 4th Year',
                                fsize: 22.0,
                                clr: Colors.white,
                                fweight: FontWeight.w500),
                            // customText(
                            //     txt: 'CSE 4th Year',
                            //     fsize: 20.0,
                            //     clr: Colors.white,
                            //     fweight: FontWeight.w400),
                            customText(
                                txt: 'Student: 11',
                                fsize: 19.0,
                                clr: Colors.white,
                                fweight: FontWeight.w300)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}


// customText(
//                           txt: 'Cloud\nComputing',
//                           fsize: 22.0,
//                           clr: Colors.white,
//                           fweight: FontWeight.w500),
                      // customText(
                      //     txt: 'CSE 4th Year',
                      //     fsize: 20.0,
                      //     clr: Colors.white,
                      //     fweight: FontWeight.w400),
                      // customText(
                      //     txt: 'Student: 11',
                      //     fsize: 19.0,
                      //     clr: Colors.white,
                      //     fweight: FontWeight.w300)