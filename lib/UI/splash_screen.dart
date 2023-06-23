import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bipres/controller/pref_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefController prefController = Get.put(PrefController());

  void initState() {
    autoLogin();
    print(prefController.myDataPref.length);
    super.initState();
  }

  Future<void> autoLogin() async {
    // Get.offNamed(RouteName.login_screen);

    // Check ada data?
    if (prefController.myDataPref.length > 0) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offNamed(RouteName.main_user_screen);
      });
    }

    Future.delayed(const Duration(seconds: 4), () {
      Get.offNamed(RouteName.login_screen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFF9D876), Color(0xFF98B66E)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
