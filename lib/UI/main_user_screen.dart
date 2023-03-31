import 'package:bipres/UI/admin/athletes_screen.dart';
import 'package:bipres/UI/home_screen copy.dart';
import 'package:bipres/UI/profile_screen.dart';
import 'package:bipres/UI/statistic_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class MainUserScreen extends StatefulWidget {
  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _screens = <Widget>[
    HomeScreen(),
    StatisticScreen(),
    AhtletesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          iconSize: 24,
          height: 70,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              activeColor: Color(0xFF98B66E),
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            FlashyTabBarItem(
              activeColor: Color(0xFF98B66E),
              icon: Icon(Icons.bar_chart),
              title: Text('Statistik'),
            ),
            FlashyTabBarItem(
              activeColor: Color(0xFF98B66E),
              icon: Icon(Icons.group),
              title: Text('Athletes'),
            ),
            FlashyTabBarItem(
              activeColor: Color(0xFF98B66E),
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
