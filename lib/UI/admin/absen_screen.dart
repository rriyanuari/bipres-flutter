import 'dart:convert';

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
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                              ':   5',
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
                              ':   3',
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
                              ':   2',
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

class AbsenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogAbsen = controller.logAbsen;
    print(LogAbsen);

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

                      // Render data items
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: MyExpansionTile(
                              title: data.tanggal_pertemuan,
                              TempatLatihan: data.tempat_latihan));
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
