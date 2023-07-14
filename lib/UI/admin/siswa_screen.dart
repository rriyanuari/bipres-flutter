import 'dart:convert';

import 'package:bipres/UI/admin/siswa_edit_screen.dart';
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

final controller = Get.put(SiswaController());

void openDialog(BuildContext context, String id, idUser, nama) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Siswa'),
        content: Text('Apakah anda yakin ingin menghapus data ( $nama )?'),
        actions: <Widget>[
          TextButton(
            child: Text('Tutup'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Hapus'),
            onPressed: () {
              controller.deleteSiswa(context, id, idUser);
            },
          ),
        ],
      );
    },
  );
}

class MyExpansionTile extends StatefulWidget {
  final siswa;
  final String namaLengkap,
      id,
      idUser,
      tanggalLahir,
      jenisKelamin,
      sabuk,
      TempatLatihan;

  MyExpansionTile({
    required this.siswa,
    required this.namaLengkap,
    required this.id,
    required this.idUser,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.sabuk,
    required this.TempatLatihan,
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
        widget.TempatLatihan,
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
                            'Tanggal Lahir',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.tanggalLahir}',
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
                            'Jenis Kelamin',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.jenisKelamin}',
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
                        child: Text('Ubah'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          Get.to(() => SiswaEditScreen(widget.siswa));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Hapus'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          openDialog(context, widget.id, widget.idUser,
                              widget.namaLengkap);
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

class SiswaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final siswa = controller.siswa;

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
              'Master Data Siswa',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getSiswa,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.siswa.length,
                    itemBuilder: (context, index) {
                      final data = controller.siswa[index];

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
                              TempatLatihan: data.TempatLatihan));
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.siswa_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
