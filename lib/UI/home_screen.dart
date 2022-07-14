import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget menu(String textTitle, textIcon, textRoutes) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 0.5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 6)),
        ],
      ),
      child: Center(
        child: ListTile(
          leading: Icon(
            textIcon,
            color: Color(0xfff009c3d),
          ),
          title: Text(
            textTitle,
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
          onTap: () {
            Get.toNamed(textRoutes);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: Color(0xfff009c3d),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/logo.png'))),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    "Hi, Riyanuari",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Good Morning",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  )
                                ])),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text(
                                                    'Apakah anda ingin logout?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                      Get.offNamed(RouteName
                                                          .login_screen);
                                                    }),
                                                    child: const Text('Ok'),
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                      size: 30,
                                    ))
                              ],
                            )
                          ])),
                  Container(
                      height: 540,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 15, right: 15),
                          child: Column(children: <Widget>[
                            Row(children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: menu("Sekolah", Icons.school,
                                    RouteName.sekolah_screen),
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                fit: FlexFit.loose,
                                child: menu("Kategori", Icons.category,
                                    RouteName.sekolah_screen),
                              ),
                            ]),
                            SizedBox(height: 20),
                            Row(children: [
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: menu("Latihan", Icons.model_training,
                                      RouteName.sekolah_screen)),
                              SizedBox(width: 20),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: menu("Test", Icons.score,
                                      RouteName.sekolah_screen)),
                            ]),
                            SizedBox(height: 50),
                            Column(
                              children: [
                                menu("Athletes", Icons.group,
                                    RouteName.sekolah_screen),
                                SizedBox(
                                  height: 30,
                                ),
                                menu("Athletes", Icons.group,
                                    RouteName.sekolah_screen),
                              ],
                            )
                          ])))
                ])));
  }
}
