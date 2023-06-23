import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String? saved_status = preferences.getString('saved_status');
      String? saved_username = preferences.getString('saved_username');
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('saved_status');
    preferences.remove('saved_username');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil logout, anda akan dialihkan"),
      backgroundColor: Colors.red,
    ));

    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteName.login_screen),
    );
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ('assets/images/logo.png'),
                  width: 100,
                ),
                Container(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    minWidth: 400.0,
                    height: 50.0,
                    color: Color(0xFFFBE39D),
                    child: Text(
                      "KELUAR",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF98B66E),
                      ),
                    ),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Apakah anda ingin keluar?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      signOut();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ));
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
