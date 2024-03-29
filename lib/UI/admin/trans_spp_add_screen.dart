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

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

class TransSppAddScreen extends StatefulWidget {
  @override
  _TransSppAddScreenState createState() => _TransSppAddScreenState();
}

class _TransSppAddScreenState extends State<TransSppAddScreen> {
  final sppcontroller = Get.put(SppController());
  final siswaController = Get.put(SiswaController());

  final _key = new GlobalKey<FormState>();

  String? total_tagihan,
      selectedNama,
      selectedIdNama,
      selectedTahun,
      selectedIdTahun,
      selectedTagihan;
  int? selectedBulan, totalBiayaInt;
  double? tagihan_per_bulan, totalBiaya;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final siswa = siswaController.siswa;
    final spp = sppcontroller.Spp;

    void reset() {
      setState(() {
        selectedNama = null;
        selectedIdNama = null;
        selectedTahun = null;
        selectedIdTahun = null;
        selectedTagihan = null;
        selectedBulan = null;
        tagihan_per_bulan = null;
        totalBiaya = null;
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

    void pickerTahun(BuildContext context) {
      Picker(
        adapter: PickerDataAdapter(data: [
          for (var data in spp)
            PickerItem(text: Text(data.tahun_periode), value: data),
        ]),
        hideHeader: true,
        title: Text('Pilih Periode'),
        onConfirm: (Picker picker, List<int> value) {
          setState(() {
            selectedTahun = picker.getSelectedValues()[0].tahun_periode;
            selectedIdTahun = picker.getSelectedValues()[0].id;
            selectedTagihan = picker.getSelectedValues()[0].total_tagihan;
            tagihan_per_bulan = int.parse(selectedTagihan!) / 12;
          });
        },
      ).showDialog(context);
    }

    void pickerBulan(BuildContext context) {
      Picker(
        adapter: PickerDataAdapter(data: [
          for (var data = 1; data <= 12; data++)
            PickerItem(text: Text(data.toString()), value: data),
        ]),
        hideHeader: true,
        title: Text('Pilih Bulan'),
        onConfirm: (Picker picker, List<int> value) {
          setState(() {
            selectedBulan = picker.getSelectedValues()[0];
            totalBiaya = tagihan_per_bulan! * selectedBulan!;
            totalBiayaInt = totalBiaya?.round();
          });
        },
      ).showDialog(context);
    }

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();

        print(selectedIdNama);
        print(selectedIdTahun.toString());
        print(totalBiayaInt);

        // return false;
        sppcontroller.addTransaksiSpp(
            context, selectedIdNama, selectedIdTahun.toString(), totalBiayaInt);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Tambah Pembayaran SPP',
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
                            'Cari siswa',
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
                          'Pilih Tahun Periode',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () => pickerTahun(context),
                          child: Text(
                            'Cari periode',
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
                          'Total Bulan',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: primaryColor,
                          onPressed: () => pickerBulan(context),
                          child: Text(
                            'Bulan',
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
                          'Ringkasan Pembayaran',
                          style: h5.copyWith(fontWeight: bold),
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
                          'Tahun Periode',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          selectedTahun == null
                              ? ':     Silahkan pilih tahun'
                              : ':     ${selectedTahun} (Rp. ${tagihan_per_bulan} )',
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
                          'Total Bulan',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          selectedBulan == null
                              ? ':     Pilih berapa banyak bulan'
                              : ':     ${selectedBulan}',
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
                          'Total biaya spp',
                          style: h5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          totalBiaya == null
                              ? ':     Rp. -'
                              : ':     Rp. ${totalBiaya}',
                          style: h5,
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
                    child: Text('Simpan Pembayaran',
                        style: h5.copyWith(color: whiteColor)),
                  ),
                  // Nonaktifkan tombol jika isLoading bernilai true
                  // atau jika form sedang diproses
                ],
              ),
            ),
            loadingWidget(context, sppcontroller.isLoading.value)
          ],
        ),
      ),
    );
  }
}
