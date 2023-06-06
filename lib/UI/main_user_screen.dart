import 'package:bipres/UI/admin/athletes_screen.dart';
import 'package:bipres/UI/admin/masterData_screen.dart';
import 'package:bipres/UI/home_screen.dart';
import 'package:bipres/UI/profile_screen.dart';
import 'package:bipres/UI/statistic_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bipres/controller/pref_controller.dart';

class MainUserScreen extends StatefulWidget {
  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  final PrefController prefController = Get.put(PrefController());

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _screensAdmin = <Widget>[
    HomeScreen(),
    ProfileScreen(),
    MasterDataScreen(),
  ];

  static List<Widget> _screensAnggota = <Widget>[
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _tabBarAdmin = FlashyTabBar(
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
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
        FlashyTabBarItem(
          activeColor: Color(0xFF98B66E),
          icon: Icon(Icons.dashboard_customize),
          title: Text('Master Data'),
        ),
      ],
    );

    Widget _tabBarAnggota = FlashyTabBar(
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
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: prefController.myDataPref.toJson()['saved_role'] == 'admin'
            ? _screensAdmin[_selectedIndex]
            : _screensAnggota[_selectedIndex],
        bottomNavigationBar:
            prefController.myDataPref.toJson()['saved_role'] == 'admin'
                ? _tabBarAdmin
                : _tabBarAnggota,
      ),
    );
  }
}
