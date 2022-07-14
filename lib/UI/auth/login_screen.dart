import 'dart:ui';

import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerSubmit() async {
    // try {
    //   await _firebaseAuth.createUserWithEmailAndPassword(
    //       email: _emailController.text.toString().trim(),
    //       password: _passwordController.text);
    //   _emailController.clear();
    //   _passwordController.clear();
    // } catch (e) {
    //   print(e);
    //   print("mantap");
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(e.toString())));
    // }
  }

  loginSubmit() async {
    // try {
    //   _firebaseAuth
    //       .signInWithEmailAndPassword(
    //           email: _emailController.text, password: _passwordController.text)
    //       .then((value) => Get.offNamed(RouteName.main_screen));
    // } catch (e) {
    //   print(e);
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(e.toString())));
    // }
  }

  Widget userInput(
      TextEditingController userInput, String hintTitle, bool obscureText) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 15, right: 10),
      child: TextField(
        controller: userInput,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xffffff002)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xffffff002)),
          ),
          hintText: hintTitle,
          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      ),
    );
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            height: 510,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff009c3d),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                      userInput(_emailController, "Username", false),
                      SizedBox(
                        height: 10,
                      ),
                      userInput(_passwordController, "Password", true),
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
                      onPressed: () {
                        Get.offNamed(RouteName.main_user_screen);
                        // loginSubmit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
