import 'package:bipres/controller/auth_controller.dart';
import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/shared/theme.dart';

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class UbahPasswordScreen extends StatefulWidget {
  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  String? passworBaru, passwordLama;
  bool _secureLama = true;
  bool _secureBaru = true;

  final authController = Get.put(AuthController());
  final prefController = Get.put(PrefController());

  final _key = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? id = prefController.myDataPref['id_user'];

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();

        authController.editPassword(
          context,
          id,
          passwordLama,
          passworBaru,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Ubah Password',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  validator: (e) {
                    if ((e as dynamic).isEmpty) {
                      return "Password lama tidak boleh kosong";
                    }
                  },
                  obscureText: _secureLama,
                  onSaved: (e) => passwordLama = e,
                  decoration: InputDecoration(
                    labelText: "Password Lama",
                    fillColor: whiteColor,
                    suffixIcon: IconButton(
                      icon: Icon(_secureLama
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _secureLama = !_secureLama;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (e) {
                    if ((e as dynamic).isEmpty) {
                      return "Password baru tidak boleh kosong";
                    }
                  },
                  obscureText: _secureBaru,
                  onSaved: (e) => passworBaru = e,
                  decoration: InputDecoration(
                    labelText: "Password Baru",
                    fillColor: whiteColor,
                    suffixIcon: IconButton(
                      icon: Icon(_secureBaru
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _secureBaru = !_secureBaru;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: () => check(),
                  child: Text(
                    'Simpan',
                    style: h4.copyWith(fontWeight: bold, color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => loadingWidget(context, authController.isLoading.value))
        ],
      ),
    );
  }
}
