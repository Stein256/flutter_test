import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './event_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cup = SvgPicture.asset('assets/cup.svg');
    return MaterialApp(
        title: 'Flutter Test App',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text('Flutter Test App'),
            ),
          ),
          body: Center(
            child: EventList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'My Team',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Scanner',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Gallery',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Profile',
                ),
              ],
              currentIndex: 0,
              showUnselectedLabels: true,
              selectedItemColor: Colors.blue,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 9, color: Colors.blue),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                  color: Colors.grey)),
        ));
  }
}
