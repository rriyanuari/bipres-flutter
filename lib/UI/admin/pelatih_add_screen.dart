import 'dart:developer';
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

class PelatihAddScreen extends StatefulWidget {
  const PelatihAddScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PelatihAddScreenState createState() => _PelatihAddScreenState();
}

class _PelatihAddScreenState extends State<PelatihAddScreen> {
  final tempatController = Get.put(TempatLatihanController());
  final pelatihController = Get.put(PelatihController());
  final tingkatanController = Get.put(TingkatanController());

  final _key = new GlobalKey<FormState>();

  String? namaDepan, namaBelakang, namaLengkap;
  String? selectedJenisKelamin = dropdownJenisKelaminItems.first.value;
  String? selectedTempatLatihan;
  DateTime selectedDate = DateTime.now();

  int tahun_pengesahan = DateTime.now().year;
  int startYear = DateTime.now().year - 50;
  int endYear = DateTime.now().year;

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

  void _showYearPicker(BuildContext context) {
    Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(
            begin: startYear, end: endYear, initValue: tahun_pengesahan)
      ]),
      delimiter: [
        PickerDelimiter(child: Container(width: 30.0)),
      ],
      hideHeader: true,
      title: Text('Pilih Tahun'),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          tahun_pengesahan = value[0] + startYear;
        });
      },
    ).showDialog(context);
  }

  check(context) {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();

      pelatihController.addPelatih(
        context,
        namaDepan,
        namaBelakang,
        namaLengkap,
        selectedJenisKelamin,
        selectedDate.toString().substring(0, 10),
        tahun_pengesahan.toString(),
        selectedTempatLatihan,
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tahun Pengesahan :   " + "${tahun_pengesahan}",
                        style: h5,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () => _showYearPicker(context),
                        child: const Text('Pilih Tahun'),
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
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedJenisKelamin = newValue!;
                    });
                  },
                  items: dropdownJenisKelaminItems,
                ),
                SizedBox(height: 10),
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
          Obx(() => loadingWidget(context, pelatihController.isLoading.value))
        ],
      ),
    );
  }
}
