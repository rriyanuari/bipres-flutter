import 'dart:convert';
import 'dart:developer';

import 'package:bipres/api/api.dart';
import 'package:bipres/controller/log_absen_controller.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/models/log_absen_model.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

class AbsenDetailScreen extends StatefulWidget {
  @override
  _AbsenDetailScreenState createState() => _AbsenDetailScreenState();
  final AbsenModel data;

  AbsenDetailScreen(this.data);
}

class _AbsenDetailScreenState extends State<AbsenDetailScreen> {
  final controller = Get.put(LogAbsenController());

  @override
  Widget build(BuildContext context) {
    inspect(widget.data);
    final absen = widget.data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Detail Absen',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
            onRefresh: controller.getLogAbsen,
            child: controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Informasi Latihan',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Tempat Latihan',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.tempat_latihan}',
                                style: h5.copyWith(fontWeight: light),
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
                              flex: 1,
                              child: Text(
                                'Tanggal Latihan',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.tanggal_pertemuan}',
                                style: h5.copyWith(fontWeight: light),
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
                              flex: 1,
                              child: Text(
                                'Pin Absensi',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.pin_absen}',
                                style: h5.copyWith(fontWeight: light),
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
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Informasi Absensi',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Total Siswa',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.total_siswa}',
                                style: h5.copyWith(fontWeight: light),
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
                              flex: 1,
                              child: Text(
                                'Siswa Absen',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.total_siswa_absen}',
                                style: h5.copyWith(fontWeight: light),
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
                              flex: 1,
                              child: Text(
                                'Siswa Tidak Absen',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${absen.total_siswa_absen}',
                                style: h5.copyWith(fontWeight: light),
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
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Daftar Siswa Absen',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        absen.total_siswa_absen == '0'
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: Text(
                                    '-----   Belum ada siswa yang absen   -----',
                                    style: h5.copyWith(fontWeight: regular),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: absen.logAbsen.length,
                                  itemBuilder: (context, index) {
                                    final data = absen.logAbsen[index];
                                    inspect(data);

                                    // Render data items
                                    return Column(
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            '${data.nama_lengkap}',
                                            style: h5.copyWith(
                                                fontWeight: regular),
                                          ),
                                          subtitle: Text(
                                            '${data.log_time}',
                                            style: h5.copyWith(
                                                fontWeight: regular),
                                          ),
                                        ),
                                        Divider(thickness: 1),
                                      ],
                                    );

                                    // Co
                                  },
                                ),
                              )
                      ],
                    ),
                  )),
      ),
    );
  }
}
