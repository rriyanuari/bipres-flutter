import 'dart:convert';

import 'package:bipres/UI/admin/absen_detail_screen.dart';
import 'package:bipres/api/api.dart';
import 'package:bipres/controller/log_absen_controller.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

final controller = Get.put(LogAbsenController());

class MyExpansionTile extends StatefulWidget {
  final absen,
      title,
      pinAbsen,
      tempatLatihan,
      total_siswa,
      siswa_absen,
      siswa_tidak_absen;

  MyExpansionTile(
      {required this.absen,
      required this.title,
      required this.pinAbsen,
      required this.tempatLatihan,
      required this.total_siswa,
      required this.siswa_absen,
      required this.siswa_tidak_absen});

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: secondaryColor,
      backgroundColor: secondaryColor,
      textColor: blackColor,
      collapsedTextColor: blackColor,
      collapsedIconColor: blackColor,
      iconColor: blackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        widget.title,
        style: h4.copyWith(fontWeight: bold),
      ),
      subtitle: Text(
        widget.tempatLatihan,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: <Widget>[
        Container(
            color: whiteColorTrans, // Ubah warna latar belakang header
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Pin Absensi',
                              style: h5.copyWith(fontWeight: regular),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              ':   ${widget.pinAbsen}',
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
                            flex: 2,
                            child: Text(
                              'Total Siswa',
                              style: h5.copyWith(fontWeight: regular),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              ':   ${widget.total_siswa}',
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
                            flex: 2,
                            child: Text(
                              'Siswa Absen',
                              style: h5.copyWith(fontWeight: regular),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              ':   ${widget.siswa_absen}',
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
                            flex: 2,
                            child: Text(
                              'Siswa Tidak Absen',
                              style: h5.copyWith(fontWeight: regular),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              ':   ${widget.siswa_tidak_absen}',
                              style: h5.copyWith(fontWeight: light),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Detail'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          Get.to(() => AbsenDetailScreen(widget.absen));
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}

class AbsenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogAbsen = controller.logAbsen;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.watch,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Data Absen',
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
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.logAbsen.length,
                    itemBuilder: (context, index) {
                      final data = controller.logAbsen[index];
                      final siswa_tidak_masuk = int.parse(data.total_siswa) -
                          int.parse(data.total_siswa_absen);

                      // Render data items
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: MyExpansionTile(
                            absen: data,
                            title: data.tanggal_pertemuan,
                            tempatLatihan: data.tempat_latihan,
                            pinAbsen: data.pin_absen,
                            total_siswa: data.total_siswa,
                            siswa_absen: data.total_siswa_absen,
                            siswa_tidak_absen: siswa_tidak_masuk.toString(),
                          ));
                      // Co
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.absen_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
