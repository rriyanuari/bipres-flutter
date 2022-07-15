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
        backgroundColor: Colors.blue,
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            // fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/background.jpg',
            ),
          ),
        ),
        child: Form(
          key: _key,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 510,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xfff009c3d),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
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
                                labelText: "username",
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
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.black)),
                            minWidth: 400.0,
                            height: 42.0,
                            color: Color(0xffffff002),
                            child: Text("Login"),
                            onPressed: () => check(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
