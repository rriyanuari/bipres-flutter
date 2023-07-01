import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/shared/theme.dart';

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class TempatLatihanAddScreen extends StatefulWidget {
  @override
  _TempatLatihanAddScreenState createState() => _TempatLatihanAddScreenState();
}

class _TempatLatihanAddScreenState extends State<TempatLatihanAddScreen> {
  String? tempatLatihan;

  final controller = Get.put(TempatLatihanController());

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();

      controller.addTempatLatihan(context, tempatLatihan);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Icon(
              Icons.group,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Tambah Tempat Latihan',
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
                      return "Nama tempat latihan tidak boleh kosong";
                    }
                  },
                  onSaved: (e) => tempatLatihan = e,
                  decoration: InputDecoration(labelText: "Nama Tempat Latihan"),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: controller.isLoading.value ? null : () => check(),
                  child: Text(
                    'Simpan',
                    style: h4.copyWith(fontWeight: bold, color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => loadingWidget(context, controller.isLoading.value))
        ],
      ),
    );
  }
}
