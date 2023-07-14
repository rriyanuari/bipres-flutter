import 'dart:convert';
import 'dart:developer';

import 'package:bipres/UI/admin/tes_kenaikan_detail_screen.dart';
import 'package:bipres/api/api.dart';
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

final siswaController = Get.put(SiswaController());

class MyExpansionTile extends StatefulWidget {
  final siswa;
  final String namaLengkap,
      id,
      idUser,
      tanggalLahir,
      jenisKelamin,
      sabuk,
      tempatLatihan;
  final tingkatan;

  MyExpansionTile({
    required this.siswa,
    required this.namaLengkap,
    required this.id,
    required this.idUser,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.sabuk,
    required this.tempatLatihan,
    required this.tingkatan,
  });

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
        widget.namaLengkap,
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Tingkatan Sabuk',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.sabuk}',
                            style: h5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              value:
                                  widget.tingkatan[0]['sikap_pasang_4'] == '0'
                                      ? false
                                      : true,
                              onChanged: (bool? value) {},
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
                              value:
                                  widget.tingkatan[0]['sikap_pasang_8'] == '0'
                                      ? false
                                      : true,
                              onChanged: (bool? value) {},
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
                              value: widget.tingkatan[0]
                                          ['jurus_tangan_kosong'] ==
                                      '0'
                                  ? false
                                  : true,
                              onChanged: (bool? value) {},
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
                              value: widget.tingkatan[0]
                                          ['jurus_senjata_golok'] ==
                                      '0'
                                  ? false
                                  : true,
                              onChanged: (bool? value) {},
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
                              value: widget.tingkatan[0]
                                          ['jurus_senjata_toya'] ==
                                      '0'
                                  ? false
                                  : true,
                              onChanged: (bool? value) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Detail'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          Get.to(
                            () => TesKenaikanDetailScreen(widget.siswa),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class TesKenaikanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    siswaController.getSiswaWithTingkatan();
    final siswa = siswaController.siswa;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.group,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Data Kemampuan Siswa',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: siswaController.getSiswaWithTingkatan,
          child: siswaController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: siswaController.siswa.length,
                    itemBuilder: (context, index) {
                      final data = siswaController.siswa[index];

                      // Render data items
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: MyExpansionTile(
                              siswa: data,
                              namaLengkap: data.namaLengkap,
                              id: data.id,
                              idUser: data.idUser,
                              jenisKelamin: data.jenisKelamin,
                              sabuk: data.Sabuk,
                              tanggalLahir: data.tanggalLahir,
                              tempatLatihan: data.TempatLatihan,
                              tingkatan: data.Tingkatan));
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.tes_kenaikan_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
