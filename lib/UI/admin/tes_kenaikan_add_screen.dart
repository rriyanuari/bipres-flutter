import 'dart:developer';
import 'package:bipres/controller/log_absen_controller.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:bipres/controller/Pelatih_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/controller/tingkatan_controller.dart';

import 'package:bipres/shared/theme.dart';

class TesKenaikanAddScreen extends StatefulWidget {
  const TesKenaikanAddScreen({super.key});

  @override
  _TesKenaikanAddScreenState createState() => _TesKenaikanAddScreenState();
}

class _TesKenaikanAddScreenState extends State<TesKenaikanAddScreen> {
  final sppController = Get.put(SppController());
  final tingkatanController = Get.put(TingkatanController());
  final siswaController = Get.put(SiswaController());

  final _key = new GlobalKey<FormState>();

  String? total_tagihan,
      selectedNama,
      selectedIdNama,
      selectedTingkatan,
      selectedIdTingkatan;

  var nilaiFisik;

  bool sikap_pasang_4 = false;
  bool sikap_pasang_8 = false;
  bool jurus_tangan_kosong = false;
  bool jurus_senjata_golok = false;
  bool jurus_senjata_toya = false;

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siswa = siswaController.siswa;
    final tingkatan = tingkatanController.tingkatan;
    final spp = sppController.Spp;

    void reset() {
      setState(() {
        selectedNama = null;
        selectedIdNama = null;
        selectedTingkatan = null;
        selectedIdTingkatan = null;
        nilaiFisik = '';
        sikap_pasang_4 = false;
        sikap_pasang_8 = false;
        jurus_tangan_kosong = false;
        jurus_senjata_golok = false;
        jurus_senjata_toya = false;
      });
    }

    void pickerSiswa(BuildContext context) {
      Picker(
        adapter: PickerDataAdapter(data: [
          for (var data in siswa)
            PickerItem(text: Text(data.namaLengkap), value: data),
        ]),
        hideHeader: true,
        title: Text('Pilih Siswa'),
        onConfirm: (Picker picker, List<int> value) {
          setState(() {
            selectedNama = picker.getSelectedValues()[0].namaLengkap;
            selectedIdNama = picker.getSelectedValues()[0].id;
          });
        },
      ).showDialog(context);
    }

    void pickerTingkatan(BuildContext context) {
      Picker(
        adapter: PickerDataAdapter(data: [
          for (var data in tingkatan)
            PickerItem(text: Text(data.sabuk), value: data),
        ]),
        hideHeader: true,
        title: Text('Pilih Tingktan'),
        onConfirm: (Picker picker, List<int> value) {
          setState(() {
            selectedTingkatan = picker.getSelectedValues()[0].sabuk;
            selectedIdTingkatan = picker.getSelectedValues()[0].id;
          });
        },
      ).showDialog(context);
    }

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();

        var val_sikap_pasang_4 = (sikap_pasang_4) ? "1" : "0";
        var val_sikap_pasang_8 = (sikap_pasang_8) ? "1" : "0";
        var val_jurus_tangan_kosong = (jurus_tangan_kosong) ? "1" : "0";
        var val_jurus_senjata_golok = (jurus_senjata_golok) ? "1" : "0";
        var val_jurus_senjata_toya = (jurus_senjata_toya) ? "1" : "0";

        // return false;
        tingkatanController.addTestKenaikan(
            context,
            selectedIdNama,
            selectedIdTingkatan.toString(),
            nilaiFisik,
            val_sikap_pasang_4,
            val_sikap_pasang_8,
            val_jurus_tangan_kosong,
            val_jurus_senjata_golok,
            val_jurus_senjata_toya);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Tes Kenaikan Tingkat Siswa',
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
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Pilih siswa',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () => pickerSiswa(context),
                          child: Text(
                            'Cari',
                            style: h5.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Pilih Tingkatan',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () => pickerTingkatan(context),
                          child: Text(
                            'Cari',
                            style: h5.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Divider(
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Form Penilaian Tes',
                          style: h4.copyWith(fontWeight: bold),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () => reset(),
                          child: Text(
                            'Reset',
                            style: h5.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Siswa',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          selectedNama == null
                              ? ':     Silahkan pilih siswa'
                              : ':     ${selectedNama} - ${selectedIdNama}',
                          style: h5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Tingkatan Sabuk',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          selectedTingkatan == null
                              ? ':     Silahkan pilih tingkatan'
                              : ':     ${selectedTingkatan}',
                          style: h5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    validator: (e) {
                      if ((e as dynamic).isEmpty) {
                        return "Nilai wajib diisi";
                      }
                    },
                    focusNode: myFocusNode,
                    onSaved: (e) => nilaiFisik = e,
                    decoration:
                        InputDecoration(labelText: "Nilai Fisik ( 1 - 100)"),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Sikap Pasang 1 - 4',
                        style: h5,
                      )),
                      Expanded(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: sikap_pasang_4,
                          onChanged: (bool? value) {
                            setState(() {
                              sikap_pasang_4 = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Sikap Pasang 4 - 8',
                        style: h5,
                      )),
                      Expanded(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: sikap_pasang_8,
                          onChanged: (bool? value) {
                            setState(() {
                              sikap_pasang_8 = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Jurus Tangan Kosong',
                        style: h5,
                      )),
                      Expanded(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: jurus_tangan_kosong,
                          onChanged: (bool? value) {
                            setState(() {
                              jurus_tangan_kosong = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Jurus Senjata Golok',
                        style: h5,
                      )),
                      Expanded(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: jurus_senjata_golok,
                          onChanged: (bool? value) {
                            setState(() {
                              jurus_senjata_golok = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Jurus Senjata Toya',
                        style: h5,
                      )),
                      Expanded(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: jurus_senjata_toya,
                          onChanged: (bool? value) {
                            setState(() {
                              jurus_senjata_toya = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50),
                  MaterialButton(
                    padding: EdgeInsets.all(10.0),
                    color: primaryColor,
                    onPressed:
                        siswaController.isLoading.value ? null : () => check(),
                    child: Text('Simpan Penilaian',
                        style: h5.copyWith(color: whiteColor)),
                  ),
                  // Nonaktifkan tombol jika isLoading bernilai true
                  // atau jika form sedang diproses
                ],
              ),
            ),
            // loadingWidget(context, sppcontroller.isLoading.value)
          ],
        ),
      ),
    );
  }
}
