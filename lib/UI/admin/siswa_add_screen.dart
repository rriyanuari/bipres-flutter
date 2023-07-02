import 'dart:convert';
import 'dart:io';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/controller/tingkatan_controller.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

// import '../../../models/jabatan_model.dart';
// import '../../../api/api.dart';

List<DropdownMenuItem<String>> get dropdownJenisKelaminItems {
  List<DropdownMenuItem<String>> menuJenisKelaminItems = [
    DropdownMenuItem(child: Text("Pilih Jenis Kelamin"), value: ""),
    DropdownMenuItem(child: Text("Putra"), value: "Putra"),
    DropdownMenuItem(child: Text("Putri"), value: "Putri"),
  ];
  return menuJenisKelaminItems;
}

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class SiswaAddScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SiswaAddScreenState createState() => _SiswaAddScreenState();
}

class _SiswaAddScreenState extends State<SiswaAddScreen> {
  final siswaController = Get.put(SiswaController());
  final tempatController = Get.put(TempatLatihanController());
  final tingkatanController = Get.put(TingkatanController());

  final _key = new GlobalKey<FormState>();

  String? namaDepan, namaBelakang, namaLengkap;
  String? selectedJenisKelamin = dropdownJenisKelaminItems.first.value;
  String? selectedTingkatan;
  String? selectedTempatLatihan;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  check(context) {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();

      siswaController.addSiswa(
          context,
          namaDepan,
          namaBelakang,
          namaLengkap,
          selectedJenisKelamin,
          selectedDate.toString().substring(0, 10),
          selectedTempatLatihan,
          selectedTingkatan);
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
              'Tambah Siswa',
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
                      return "Nama depan tidak boleh kosong";
                    }
                  },
                  onSaved: (e) => namaDepan = e,
                  decoration: InputDecoration(labelText: "Nama Depan"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (e) {
                    if ((e as dynamic).isEmpty) {
                      return "Nama belakang tidak boleh kosong";
                    }
                  },
                  onSaved: (e) => namaBelakang = e,
                  decoration: InputDecoration(labelText: "Nama Belakang"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (e) {
                    if ((e as dynamic).isEmpty) {
                      return "Nama lengkap tidak boleh kosong";
                    }
                  },
                  onSaved: (e) => namaLengkap = e,
                  decoration: InputDecoration(labelText: "Nama Lengkap"),
                ),
                SizedBox(height: 30),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tanggal lahir :   " +
                            "${selectedDate.toLocal()}".split(' ')[0],
                        style: h5,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Pilih Tanggal'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton(
                  hint: Text("jenis kelamin"),
                  isExpanded: true,
                  value: selectedJenisKelamin,
                  style: valueStyle.copyWith(color: Colors.grey[800]),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedJenisKelamin = newValue!;
                    });
                  },
                  items: dropdownJenisKelaminItems,
                ),
                SizedBox(height: 10),
                Obx(
                  () => tingkatanController.isLoading.value == false
                      ? DropdownButton(
                          isExpanded: true,
                          value: selectedTingkatan ??
                              tingkatanController.tingkatanItems[0].value,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTingkatan = newValue!;
                            });
                          },
                          items: tingkatanController.tingkatanItems,
                        )
                      : SizedBox(height: 0),
                ),
                SizedBox(height: 10),
                Obx(
                  () => tempatController.isLoading.value == false
                      ? DropdownButton(
                          isExpanded: true,
                          value: selectedTempatLatihan ??
                              tempatController.tempatLatihanItems[0].value,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTempatLatihan = newValue!;
                            });
                          },
                          items: tempatController.tempatLatihanItems,
                        )
                      : SizedBox(height: 0),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: () => check(context),
                  child: Text(
                    'Simpan',
                    style: h4.copyWith(fontWeight: bold, color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => loadingWidget(context, siswaController.isLoading.value))
        ],
      ),
    );
  }
}
