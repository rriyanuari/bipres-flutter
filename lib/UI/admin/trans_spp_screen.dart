import 'dart:convert';

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

class MyExpansionTile extends StatefulWidget {
  final String title, TempatLatihan;

  MyExpansionTile({required this.title, required this.TempatLatihan});

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
                ListTile(
                  title: Text('Pembayaran Terakhir',
                      style: TextStyle(color: blackColor)),
                  subtitle: Text('26-06-2023'),
                  trailing: Text('Rp. 20.000'), // Ubah warna teks header
                ),
                ListTile(
                  title:
                      Text('Sisa Tagihan', style: TextStyle(color: blackColor)),
                  subtitle: Text('( 8 Bulan )'),
                  trailing: Text('Rp. 200.000'), // Ubah warna teks header
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Detail'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          Get.toNamed(RouteName.trans_spp_detail_screen);
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

class TransSppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final siswa = controller.siswa;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.attach_money,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Data Spp Siswa',
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
                              title: data.namaLengkap,
                              TempatLatihan: data.TempatLatihan));
                      // Co
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.trans_spp_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
