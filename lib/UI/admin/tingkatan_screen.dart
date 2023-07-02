import 'package:bipres/controller/tingkatan_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';

final controller = Get.put(TingkatanController());

class MyExpansionTile extends StatefulWidget {
  final sabuk,
      id,
      min_nilai_fisik,
      sikap_pasang_4,
      sikap_pasang_8,
      jurus_tangan_kosong,
      jurus_senjata_golok,
      jurus_senjata_toya;

  MyExpansionTile({
    required this.sabuk,
    required this.id,
    required this.min_nilai_fisik,
    required this.sikap_pasang_4,
    required this.sikap_pasang_8,
    required this.jurus_tangan_kosong,
    required this.jurus_senjata_golok,
    required this.jurus_senjata_toya,
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
        widget.sabuk,
        style: h4.copyWith(fontWeight: bold),
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
                              flex: 2,
                              child: Text(
                                'Minimal Nilai Fisik',
                                style: h5,
                              )),
                          Expanded(
                              child: Text(
                            ':   ${widget.min_nilai_fisik}',
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
                                  widget.sikap_pasang_4 == '0' ? false : true,
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
                                  widget.sikap_pasang_8 == '0' ? false : true,
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
                              value: widget.jurus_tangan_kosong == '0'
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
                              value: widget.jurus_senjata_golok == '0'
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
                              value: widget.jurus_senjata_toya == '0'
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
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class TingkatanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tingkatan = controller.tingkatan;

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
              'Master Data Tingkatan',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTingkatan,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.tingkatan.length,
                    itemBuilder: (context, index) {
                      final data = controller.tingkatan[index];
                      // Render data items
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: MyExpansionTile(
                          sabuk: data.sabuk,
                          id: data.id,
                          min_nilai_fisik: data.min_nilai_fisik,
                          sikap_pasang_4: data.sikap_pasang_4,
                          sikap_pasang_8: data.sikap_pasang_8,
                          jurus_tangan_kosong: data.jurus_tangan_kosong,
                          jurus_senjata_golok: data.jurus_senjata_golok,
                          jurus_senjata_toya: data.jurus_senjata_toya,
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
