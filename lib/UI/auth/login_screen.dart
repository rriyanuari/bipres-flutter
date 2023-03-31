import 'dart:convert';
import 'dart:ui';

import 'package:bipres/api/api.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? inputUsername, inputPassword;
  bool _secureText = true;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  savePref(String saved_status, String saved_username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("saved_status", saved_status);
      preferences.setString("saved_username", saved_username);

      preferences.commit();
    });
  }

  login() async {
    final response = await http.post(Uri.parse(BaseUrl.urlLogin),
        body: {"username": inputUsername, "password": inputPassword});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];

    if (value == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${pesan}, anda akan dialihkan'),
        backgroundColor: Color(0xFF98B66E),
      ));

      String saved_status = data['status'];
      String saved_username = data['username'];

      savePref(saved_status, saved_username);
      Future.delayed(const Duration(seconds: 3),
          () => Get.offNamed(RouteName.main_user_screen));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Username atau password salah'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 1,
            color: Color(0xFF98B66E),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.1,
                    horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ('assets/images/logo.png'),
                      width: 80,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "PORTAL BIPRES",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBE39D)),
                    )
                  ],
                )),
          ),
          Container(
            child: Form(
              key: _key,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 5))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Username tidak boleh kosong";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (e) => inputUsername = e,
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                labelText: "Username",
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Password tidak boleh kosong";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => inputPassword = e,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: "password",
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            minWidth: 400.0,
                            height: 50.0,
                            color: Color(0xFF98B66E),
                            child: Text(
                              "Masuk",
                              style: TextStyle(color: Color(0xffFBE39D)),
                            ),
                            onPressed: () => check(),
                            // onPressed: () => Future.delayed(
                            //     const Duration(seconds: 3),
                            //     () => Get.offNamed(RouteName.main_user_screen)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
