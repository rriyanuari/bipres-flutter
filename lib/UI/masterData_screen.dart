import 'package:bipres/routes/route_name.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "MASTER DATA",
              style: h1.copyWith(fontWeight: bold, color: whiteColor),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: secondarySoftColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "PELATIH",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.pelatih_screen);
                            },
                          ),
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: secondarySoftColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.group,
                                  color: primaryColor,
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "SISWA",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.siswa_screen);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: secondarySoftColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "TEMPAT LATIHAN",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.tempat_latihan_screen);
                            },
                          ),
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: secondarySoftColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.stacked_bar_chart,
                                  color: primaryColor,
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "TINGKATAN",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.tingkatan_screen);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: secondarySoftColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: primaryColor,
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "SPP",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.spp_screen);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
