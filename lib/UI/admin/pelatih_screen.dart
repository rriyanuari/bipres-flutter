import 'dart:math';

import 'package:bipres/controller/Pelatih_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/shared/theme.dart';

final controller = Get.put(PelatihController());

void openDialog(BuildContext context, String id, idUser, nama) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Pelatih'),
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
              controller.deletePelatih(context, id, idUser);
            },
          ),
        ],
      );
    },
  );
}

class MyExpansionTile extends StatefulWidget {
  final String namaLengkap,
      id,
      idUser,
      tahunPengesahan,
      tanggalLahir,
      jenisKelamin,
      TempatLatihan;

  MyExpansionTile({
    required this.namaLengkap,
    required this.id,
    required this.idUser,
    required this.tahunPengesahan,
    required this.tanggalLahir,
    required this.jenisKelamin,
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
                            'Tahun Pengesahan',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.tahunPengesahan}',
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
                          Get.toNamed(RouteName.trans_spp_detail_screen);
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

class PelatihScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pelatih = controller.pelatih;

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
              'Master Data Pelatih',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getPelatih,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.pelatih.length,
                    itemBuilder: (context, index) {
                      final data = controller.pelatih[index];

                      // Render data items
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: MyExpansionTile(
                              namaLengkap: data.namaLengkap,
                              id: data.id,
                              idUser: data.idUser,
                              tahunPengesahan: data.tahunPengesahan,
                              jenisKelamin: data.jenisKelamin,
                              tanggalLahir: data.tanggalLahir,
                              TempatLatihan: data.TempatLatihan));
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.pelatih_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
