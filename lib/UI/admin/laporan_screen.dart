import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:flutter/material.dart';

import 'package:bipres/api/api.dart';

import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_picker/flutter_picker.dart';

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LaporanScreen extends StatefulWidget {
  @override
  _LaporanScreenState createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
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

  bool downloading = false;

  int tahun_periode = DateTime.now().year;
  int startYear = DateTime.now().year - 3;

  void _showYearPicker(BuildContext context) {
    Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(
            begin: startYear,
            end: DateTime.now().year,
            initValue: tahun_periode)
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

  void modalDownload(String? tipe, String? periode_tahun) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ingin download laporan'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // signOut();
              downloadFile(tipe, periode_tahun);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Future generateReport(
    String? tipe,
    String? periode_tahun,
  ) async {
    try {
      var body = {
        'periode_tahun': '$periode_tahun',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse('https://bipres.holtechno.space/api/report_${tipe}.php'),
        headers: {"user-key": 'portalbipres_api'},
        body: jsonBody,
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      modalDownload(tipe, periode_tahun);
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('gagal terhubung ke server'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  Future downloadFile(
    String? tipe,
    String? periode_tahun,
  ) async {
    setState(() {
      downloading = true;
    });

    var url =
        'https://bipres.holtechno.space/report/${tipe}/${tipe}_periode_${periode_tahun}.pdf';
    var filename = '${tipe}_periode_${periode_tahun}.pdf';

    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.post(
        url,
        data: convert.jsonEncode({"periode_tahun": "2023"}),
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          headers: {"user-key": "portalbipres_api"},
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(hours: 0, minutes: 1, seconds: 0),
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan berhasil didownload'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan gagal didownload'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
      debugPrint(e.toString());
    } finally {
      setState(() {
        downloading = false;
      });
    }
  }

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
              'Laporan',
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
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              children: <Widget>[
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
                        onPressed: () => _showYearPicker(context),
                        child: Text(
                          'Cari periode',
                          style: h5.copyWith(color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
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
                        tahun_periode == null
                            ? ':     Silahkan pilih tahun'
                            : ':     ${tahun_periode}',
                        style: h5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                        'Pilih Jenis Laporan',
                        style: h5.copyWith(fontWeight: bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                MaterialButton(
                  height: 50,
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: () {
                    tahun_periode == null
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Tahun periode harus dipilih'),
                            backgroundColor: Colors
                                .red, // Ganti dengan warna yang diinginkan
                          ))
                        : generateReport('absensi', tahun_periode.toString());
                  },
                  child: Text('Laporan Absensi',
                      style: h5.copyWith(color: whiteColor)),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  height: 50,
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: () {
                    tahun_periode == null
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Tahun periode harus dipilih'),
                            backgroundColor: Colors
                                .red, // Ganti dengan warna yang diinginkan
                          ))
                        : generateReport('spp', tahun_periode.toString());
                  },
                  child: Text('Laporan Spp',
                      style: h5.copyWith(color: whiteColor)),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  height: 50,
                  padding: EdgeInsets.all(10.0),
                  color: primaryColor,
                  onPressed: () {
                    tahun_periode == null
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Tahun periode harus dipilih'),
                            backgroundColor: Colors
                                .red, // Ganti dengan warna yang diinginkan
                          ))
                        : generateReport('tes', tahun_periode.toString());
                  },
                  child: Text('Laporan Kenaikan Tingkat',
                      style: h5.copyWith(color: whiteColor)),
                ),
              ],
            ),
          ),
          loadingWidget(context, downloading)
        ],
      ),
    );
  }
}
