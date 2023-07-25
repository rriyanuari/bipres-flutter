import 'dart:developer';

import 'package:bipres/controller/auth_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());

  Future autoLogin(isLoggedIn) async {
    // Check ada data?
    if (isLoggedIn) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offNamed(RouteName.main_user_screen);
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offNamed(RouteName.login_screen);
      });
    }
  }

  void initState() {
    // Check to pref
    authController.isLoggedIn.listen(
      (value) => {
        autoLogin(value),
      },
    );
    // End Check to pref

    super.initState();
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
