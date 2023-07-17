import 'package:bipres/UI/admin/siswa_screen.dart';
import 'package:bipres/UI/masterData_screen.dart';
import 'package:bipres/UI/home_screen.dart';
import 'package:bipres/UI/profile_screen.dart';
import 'package:bipres/UI/siswa_home_screen.dart';
import 'package:bipres/shared/theme.dart';
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

  static List<Widget> _screensPelatih = <Widget>[
    HomeScreen(),
    ProfileScreen(),
  ];

  static List<Widget> _screensAnggota = <Widget>[
    SiswaHomeScreen(),
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
      iconSize: 30,
      height: 55,
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: h4,
          ),
        ),
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.person),
          title: Text('Profile', style: h4),
        ),
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.dashboard_customize),
          title: Text('Master Data', style: h4),
        ),
      ],
    );

    Widget _tabBarPelatih = FlashyTabBar(
      iconSize: 30,
      height: 55,
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: h4,
          ),
        ),
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.person),
          title: Text('Profile', style: h4),
        ),
      ],
    );

    Widget _tabBarAnggota = FlashyTabBar(
      iconSize: 30,
      height: 55,
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.home),
          title: Text('Home', style: h4),
        ),
        FlashyTabBarItem(
          activeColor: primaryColor,
          icon: Icon(Icons.person),
          title: Text('Profile', style: h4),
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: prefController.myDataPref.toJson()['role'] == 'admin'
              ? _screensAdmin[_selectedIndex]
              : prefController.myDataPref.toJson()['role'] == 'pelatih'
                  ? _screensPelatih[_selectedIndex]
                  : _screensAnggota[_selectedIndex],
          bottomNavigationBar:
              prefController.myDataPref.toJson()['role'] == 'admin'
                  ? _tabBarAdmin
                  : prefController.myDataPref.toJson()['role'] == 'pelatih'
                      ? _tabBarPelatih
                      : _tabBarAnggota),
    );
  }
}
