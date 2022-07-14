import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    autoLogin();
    super.initState();
  }

  Future<void> autoLogin() async {
    // Get.offNamed(RouteName.login_screen);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    if (userToken != null) {
      Future.delayed(const Duration(seconds: 4), () {
        // Get.offNamed(RouteName.home_screen);
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offNamed(RouteName.onBoard_screen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 300,
            ),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
