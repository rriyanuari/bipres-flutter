import 'dart:developer';
import 'package:bipres/controller/log_absen_controller.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:bipres/controller/Pelatih_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/controller/tingkatan_controller.dart';

import 'package:bipres/shared/theme.dart';

List<DropdownMenuItem<String>> get dropdownJenisKelaminItems {
  List<DropdownMenuItem<String>> menuJenisKelaminItems = [
    const DropdownMenuItem(value: "", child: Text("Pilih Jenis Kelamin")),
    const DropdownMenuItem(value: "Putra", child: Text("Putra")),
    const DropdownMenuItem(value: "Putri", child: Text("Putri")),
  ];
  return menuJenisKelaminItems;
}

class AbsenAddScreen extends StatefulWidget {
  const AbsenAddScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AbsenAddScreenState createState() => _AbsenAddScreenState();
}

class _AbsenAddScreenState extends State<AbsenAddScreen> {
  final logAbsenController = Get.put(LogAbsenController());
  final tempatController = Get.put(TempatLatihanController());

  final _key = new GlobalKey<FormState>();

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

      logAbsenController.addJadwalLatihan(
        context,
        selectedTempatLatihan,
        selectedDate.toString().substring(0, 10),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    inspect(tempatController.tempatLatihanItems);

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
              'Tambah Jadwal Latihan',
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
                SizedBox(height: 30),
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
          Obx(() => loadingWidget(context, tempatController.isLoading.value))
        ],
      ),
    );
  }
}
