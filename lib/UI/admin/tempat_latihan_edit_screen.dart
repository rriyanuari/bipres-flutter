import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/shared/theme.dart';

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class TempatLatihanEditScreen extends StatefulWidget {
  @override
  _TempatLatihanEditScreenState createState() =>
      _TempatLatihanEditScreenState();
  final TempatLatihanModel data;

  TempatLatihanEditScreen(this.data);
}

class _TempatLatihanEditScreenState extends State<TempatLatihanEditScreen> {
  final controller = Get.put(TempatLatihanController());
  final _key = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? id = widget.data.id;
    String? tempatLatihan = widget.data.tempatLatihan;

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();

        controller.editTempatLatihan(context, id, tempatLatihan);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
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
                  initialValue: "${tempatLatihan}",
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
