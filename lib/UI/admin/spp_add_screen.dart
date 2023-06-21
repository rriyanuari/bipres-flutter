import 'dart:convert';
import 'dart:io';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_picker/flutter_picker.dart';

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class SppAddScreen extends StatefulWidget {
  @override
  _SppAddScreenState createState() => _SppAddScreenState();
}

class _SppAddScreenState extends State<SppAddScreen> {
  String? total_tagihan;
  int tahun_periode = DateTime.now().year;
  int startYear = DateTime.now().year - 3;
  int endYear = DateTime.now().year + 3;

  void _showYearPicker(BuildContext context) {
    Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(
            begin: startYear, end: endYear, initValue: tahun_periode)
      ]),
      delimiter: [
        PickerDelimiter(child: Container(width: 30.0)),
      ],
      hideHeader: true,
      title: Text('Pilih Tahun'),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          tahun_periode = value[0] + startYear;
        });
      },
    ).showDialog(context);
  }

  final controller = Get.put(SppController());

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();

      controller.addSpp(tahun_periode.toString(), total_tagihan);
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
              'Tambah Periode Spp',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Obx(() => Form(
              key: _key,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tahun Periode : ${tahun_periode}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () => _showYearPicker(context),
                        child: Text('Pilih Tahun'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Total tagihan tidak boleh kosong";
                      }
                    },
                    onSaved: (e) => total_tagihan = e,
                    decoration: InputDecoration(labelText: "Total tagihan Spp"),
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
