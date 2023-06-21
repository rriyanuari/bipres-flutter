import 'package:bipres/routes/route_name.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: Color(0xFF98B66E),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "MASTER DATA",
              style: h1.copyWith(color: whiteColor),
            ),
            SizedBox(
              height: 100,
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
                          padding: EdgeInsets.symmetric(vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBE39D),
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
                                  color: Color(0xFF98B66E),
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Pelatih",
                                  style: TextStyle(
                                      color: Color(0xFF98B66E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
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
                          padding: EdgeInsets.symmetric(vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBE39D),
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
                                  color: Color(0xFF98B66E),
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Siswa",
                                  style: TextStyle(
                                      color: Color(0xFF98B66E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
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
                  SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBE39D),
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
                                  color: Color(0xFF98B66E),
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Tempat Latihan",
                                  style: TextStyle(
                                      color: Color(0xFF98B66E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
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
                          padding: EdgeInsets.symmetric(vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBE39D),
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
                                  color: Color(0xFF98B66E),
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Tingkatan",
                                  style: TextStyle(
                                      color: Color(0xFF98B66E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(RouteName.tempat_latihan_screen);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBE39D),
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
                                  color: Color(0xFF98B66E),
                                  size: 60,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Spp",
                                  style: TextStyle(
                                      color: Color(0xFF98B66E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
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
