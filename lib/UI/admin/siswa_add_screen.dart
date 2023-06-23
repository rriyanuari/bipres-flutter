import 'dart:convert';
import 'dart:io';
import 'package:bipres/controller/siswa_controller.dart';
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

List<DropdownMenuItem<String>> get dropdownTingkatanItems {
  List<DropdownMenuItem<String>> menuTingkatanItems = [
    DropdownMenuItem(child: Text("Pilih Tingkatan"), value: ""),
    DropdownMenuItem(child: Text("Polos"), value: "1"),
    DropdownMenuItem(child: Text("Jambon"), value: "2"),
    DropdownMenuItem(child: Text("Hijau"), value: "3"),
    DropdownMenuItem(child: Text("Putih"), value: "4"),
  ];
  return menuTingkatanItems;
}

List<DropdownMenuItem<String>> get dropdownTempatLatihanItems {
  List<DropdownMenuItem<String>> menuTempatLatihanItems = [
    DropdownMenuItem(child: Text("Pilih TempatLatihan"), value: ""),
    DropdownMenuItem(child: Text("SMK Al-Hikmah"), value: "1"),
    DropdownMenuItem(child: Text("SMPN 2 Curug"), value: "2"),
  ];
  return menuTempatLatihanItems;
}

final TextStyle valueStyle = TextStyle(fontSize: 16.0);

class SiswaAddScreen extends StatefulWidget {
  @override
  _SiswaAddScreenState createState() => _SiswaAddScreenState();
}

class _SiswaAddScreenState extends State<SiswaAddScreen> {
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

  String? namaDepan, namaBelakang, namaLengkap;
  String? selectedJenisKelamin = dropdownJenisKelaminItems.first.value;
  String? selectedTingkatan = dropdownTingkatanItems.first.value;
  String? selectedTempatLatihan = dropdownTempatLatihanItems.first.value;
  DateTime selectedDate = DateTime.now();

  final controller = Get.put(SiswaController());

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();

      Map<String, dynamic> newData = {
        "nama_depan": namaDepan,
        "nama_belakang": namaBelakang,
        "nama_lengkap": namaLengkap,
        "jenis_kelamin": selectedJenisKelamin,
        "tanggal_lahir": selectedDate,
        "id_tempat_latihan": selectedTempatLatihan,
        "id_tingkatan": selectedTingkatan
      };

      controller.addSiswa(
          namaDepan,
          namaBelakang,
          namaLengkap,
          selectedJenisKelamin,
          selectedDate.toString().substring(0, 10),
          selectedTempatLatihan,
          selectedTingkatan);
    }
  }

  _submit() {
    print('nama depan: $namaDepan');
    print('nama belakang: $namaBelakang');
    print('nama lengkap: $namaLengkap');
    print('jenis kelamin: $selectedJenisKelamin');
    print('tingkatan: $selectedTingkatan');
    print('tanggal lahir: $selectedDate');
    print('tempat latihan: $selectedTempatLatihan');
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
              'Tambah Siswa',
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal lahir :",
                          style: valueStyle,
                        ),
                        Text("${selectedDate.toLocal()}".split(' ')[0],
                            style: valueStyle),
                        const SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select date'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButton(
                    isExpanded: true,
                    value: selectedTingkatan,
                    style: valueStyle.copyWith(color: Colors.grey[800]),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTingkatan = newValue!;
                      });
                    },
                    items: dropdownTingkatanItems,
                  ),
                  SizedBox(height: 10),
                  DropdownButton(
                    isExpanded: true,
                    value: selectedTempatLatihan,
                    style: valueStyle.copyWith(color: Colors.grey[800]),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTempatLatihan = newValue!;
                      });
                    },
                    items: dropdownTempatLatihanItems,
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
