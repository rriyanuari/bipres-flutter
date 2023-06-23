import 'dart:convert';
import 'dart:io';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

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

      Map<String, dynamic> newData = {
        "tempat_latihan": tempatLatihan,
      };

      controller.addTempatLatihan(tempatLatihan);
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
            backgroundColor: Color(0xfff009c3d),
            title: const Text(
              'Tambah Tempat Latihan',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Obx(() => Form(
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
                    decoration:
                        InputDecoration(labelText: "Nama Tempat Latihan"),
                  ),
                  SizedBox(height: 10),

                  MaterialButton(
                    padding: EdgeInsets.all(10.0),
                    color: Color(0xfff009c3d),
                    onPressed:
                        controller.isLoading.value ? null : () => check(),
                    child: controller.isLoading.value
                        ? Text('Proses...')
                        : Text(
                            'Simpan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              backgroundColor: controller.isLoading.value
                                  ? Color.fromARGB(79, 0, 156, 60)
                                  : Color(0xfff009c3d),
                            ),
                          ),
                  ),
                  // Nonaktifkan tombol jika isLoading bernilai true
                  // atau jika form sedang diproses
                ],
              ),
            )));
  }
}
