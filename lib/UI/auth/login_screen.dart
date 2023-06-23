import 'package:bipres/controller/auth_controller.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bipres/controller/pref_controller.dart';

import 'package:bipres/shared/loadingWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PrefController prefController = Get.put(PrefController());

  String? inputUsername, inputPassword;
  bool _secureText = true;
  bool isLoading = false;
  final _key = new GlobalKey<FormState>();
  final controller = Get.put(AuthController());

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      controller.login(context, inputUsername, inputPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                color: primaryColor,
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
                          width: 120,
                        ),
                        SizedBox(
                          height: 60,
                        ),
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: greyColor,
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
                                    fillColor: whiteColor,
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
                                    fillColor: whiteColor,
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
                                color: primaryColor,
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "Masuk",
                                        style: h4.copyWith(
                                            fontWeight: regular,
                                            color: secondarySoftColor),
                                      ),
                                onPressed: () => check(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PORTAL BIPRES",
                        style: h1.copyWith(
                            fontWeight: bold, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Biro Prestasi PSHT Ranting Curug",
                        style:
                            h3.copyWith(fontWeight: regular, color: whiteColor),
                      )
                    ],
                  )),
              loadingWidget(context, controller.isLoading.value)
            ],
          ),
        ));
  }
}
