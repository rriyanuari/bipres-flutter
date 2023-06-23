import 'dart:convert';
import 'dart:io';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/models/spp_model.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_picker/flutter_picker.dart';

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

class SppEditScreen extends StatefulWidget {
  @override
  _SppEditScreenState createState() => _SppEditScreenState();
  final SppModel data;

  SppEditScreen(this.data);
}

class _SppEditScreenState extends State<SppEditScreen> {
  final controller = Get.put(SppController());
  final _key = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.data.id;
    String? total_tagihan;
    int tahun_periode = int.parse(widget.data.tahun_periode);
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

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();

        controller.editSpp(
            context, id, tahun_periode.toString(), total_tagihan);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Tambah Data SPP',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: _key,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tahun Periode : ${tahun_periode}',
                        style: h5,
                      ),
                      MaterialButton(
                        color: primaryColor,
                        onPressed: () => _showYearPicker(context),
                        child: Text(
                          'Pilih Tahun',
                          style: h5.copyWith(color: whiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.data.total_tagihan,
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Total tagihan tidak boleh kosong";
                      }
                    },
                    onSaved: (e) => total_tagihan = e,
                    decoration: InputDecoration(labelText: "Total tagihan Spp"),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    padding: EdgeInsets.all(10.0),
                    color: primaryColor,
                    onPressed:
                        controller.isLoading.value ? null : () => check(),
                    child:
                        Text('Simpan', style: h5.copyWith(color: whiteColor)),
                  ),
                  // Nonaktifkan tombol jika isLoading bernilai true
                  // atau jika form sedang diproses
                ],
              ),
            ),
            loadingWidget(context, controller.isLoading.value)
          ],
        ),
      ),
    );
  }
}
