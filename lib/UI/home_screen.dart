import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/controller/profile_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:bipres/shared/theme.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  Widget menu(String textTitle, textIcon, textRoutes) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              textIcon,
              color: primaryColor,
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              textTitle,
              style: h4.copyWith(fontWeight: bold, color: primaryColor),
            ),
          ],
        ),
        onTap: () {
          Get.toNamed(textRoutes);
        },
      ),
    );
  }

  final prefController = PrefController();
  // final profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    final pref = prefController.myDataPref;
    prefController.myDataPref();
    // final profile = profileController.Profile[0];
    // inspect(profile);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                  // const SizedBox(width: 20),
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        Text("PORTAL BIPRES",
                            style: h1.copyWith(
                                fontWeight: bold, color: primaryColor)),
                        SizedBox(height: 10),
                        Text(
                          "Biro Prestasi PSHT Ranting Curug",
                          style: h4.copyWith(
                              fontWeight: regular, color: secondaryColor),
                        )
                      ])),
                ],
              ),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "",
                            // "${profile.namaLengkap}",
                            style: h3.copyWith(
                              fontWeight: bold,
                              color: blackColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("",
                              // ("${profile.tempatLatihan} (${profile.sabuk})",
                              style: h5.copyWith(
                                  fontWeight: regular,
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/defaultProfiPic.png'))),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: GridView.count(
                primary: false,
                // padding: const EdgeInsets.all(20),
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                children: <Widget>[
                  menu("ABSEN", Icons.watch, RouteName.siswa_screen),
                  menu("SPP", Icons.attach_money, RouteName.trans_spp_screen),
                  menu("TES KENAIKAN", Icons.location_on,
                      RouteName.siswa_screen),
                  menu("LAPORAN", Icons.document_scanner,
                      RouteName.siswa_screen),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
