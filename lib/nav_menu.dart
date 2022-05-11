import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/attendance_sheet.dart';
import 'package:fyp_task/subjects_page.dart';
import 'package:fyp_task/utils.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;
  bool showNavigationBar = false;

  var list = [
    const AttendanceSheet(),
    const SubjectsPage(),
    WalkPage(),
    NotificationPage(),
    SettingsPage(),
    SearchPage()
  ];

  var title = [
    "Attendance",
    'Subjects',
    'LocationPage',
    'NotificationPage',
    'SettingsPage',
    'SearchPage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title[_selectedIndex]),
      //   centerTitle: true,
      //   toolbarHeight: 50.0,
      //   backgroundColor: const Color.fromARGB(255, 59, 58, 58),
      //   elevation: 0.0,
      // leading: IconButton(
      //     icon: const Icon(
      //       Icons.menu,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         showNavigationBar = !showNavigationBar;
      //       });
      //     }),
      // ),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned.fill(
              left: MediaQuery.of(context).size.width * 0.1,
              child: list[_selectedIndex]),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.1,
              child: NavigationRail(
                selectedIndex: _selectedIndex,
                elevation: 1.0,
                backgroundColor: const Color.fromARGB(255, 59, 58, 58),
                selectedIconTheme:
                    const IconThemeData(color: Colors.teal, size: 30),
                unselectedIconTheme:
                    const IconThemeData(color: Colors.grey, size: 20),
                selectedLabelTextStyle: const TextStyle(
                    color: Colors.teal, fontWeight: FontWeight.bold),
                unselectedLabelTextStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    // showNavigationBar = !showNavigationBar;
                  });
                },
                labelType: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? NavigationRailLabelType.all
                    : NavigationRailLabelType.none,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.present_to_all),
                    // selectedIcon: Icon(Icons.home),
                    label: Text('Attendance'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.book_sharp),
                    // selectedIcon: Icon(Icons.directions_walk),
                    label: Text('Subjects'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.location_on),
                    selectedIcon: Icon(Icons.location_on),
                    label: Text('Location'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.notifications),
                    selectedIcon: Icon(Icons.notifications),
                    label: Text('Notifications'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.search),
                    selectedIcon: Icon(Icons.search),
                    label: Text('Search'),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
          child: Text('Home Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}

class WalkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
          child: Text('Walk Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
          child: Text('Location Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
          child: Text('Notification Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Text('Settings Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
          child: Text('Search Page',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0))),
    );
  }
}
