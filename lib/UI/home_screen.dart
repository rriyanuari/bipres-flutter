import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bipres/controller/pref_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PrefController prefController = Get.put(PrefController());

  signOut() async {
    prefController.clearPref();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil logout, anda akan dialihkan"),
      backgroundColor: Colors.red,
    ));

    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteName.login_screen),
    );
  }

  Widget menu(String textTitle, textIcon, textRoutes) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFBE39D),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
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
              textIcon,
              color: Color(0xFF98B66E),
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              textTitle,
              style: TextStyle(
                  color: Color(0xFF98B66E),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
        onTap: () {
          Get.toNamed(textRoutes);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(prefController.myDataPref.toJson());
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
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
                        Text(
                          "PORTAL BIPRES",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF98B66E),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Biro Prestasi PSHT Ranting Curug",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFFBE39D)),
                        )
                      ])),
                ],
              ),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Color(0xFFFBE39D),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFF98B66E),
              ),
              child: GridView.count(
                primary: false,
                // padding: const EdgeInsets.all(20),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                children: <Widget>[
                  menu("Absen", Icons.watch, RouteName.siswa_screen),
                  menu("SPP", Icons.attach_money, RouteName.siswa_screen),
                  menu("Tes", Icons.location_on, RouteName.siswa_screen),
                  menu("Laporan", Icons.document_scanner,
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
