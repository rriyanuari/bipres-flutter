import 'dart:convert';
import 'dart:developer';

import 'package:bipres/UI/admin/trans_spp_detail_screen.dart';
import 'package:bipres/api/api.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

final sppController = Get.put(SppController());

class MyExpansionTile extends StatefulWidget {
  final transSpp;
  final tahun_periode;
  int total_tagihan;

  MyExpansionTile(
      {required this.transSpp,
      this.tahun_periode,
      required this.total_tagihan});

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double tagihan_per_bulan = widget.total_tagihan.toDouble() / 12;

    int nominal_bayar = (widget.transSpp.transaksi.length != 0)
        ? int.parse(widget.transSpp.transaksi[0].nominal_bayar)
        : 0;
    double nominal_bayar_new = nominal_bayar.toDouble();

    // HITUNG TOTAL BAYAR
    double total_nominal_bayar = 0;
    for (var transSpp in widget.transSpp.transaksi) {
      total_nominal_bayar += int.parse(transSpp.nominal_bayar);
    }

    double sisa_tagihan = widget.total_tagihan - total_nominal_bayar;

    double bulan_bayar = total_nominal_bayar / tagihan_per_bulan;
    double sisa_bulan_bayar = sisa_tagihan / tagihan_per_bulan;

    String val_bulan_bayar = bulan_bayar.toStringAsFixed(0);
    String val_sisa_bulan_bayar = sisa_bulan_bayar.toStringAsFixed(0);

    // CONVERT CURRENCY RP. FORMAT
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
    currencyFormat.maximumFractionDigits = 0;

    String total_tagihan_fix = currencyFormat.format(widget.total_tagihan);
    String tagihan_per_bulan_fix = currencyFormat.format(tagihan_per_bulan);
    String nominal_bayar_fix = currencyFormat.format(nominal_bayar_new);
    String total_nominal_bayar_fix = currencyFormat.format(total_nominal_bayar);
    String sisa_tagihan_fix = currencyFormat.format(sisa_tagihan);

    var informasi_pembayaran = {
      'tahun_periode': widget.tahun_periode,
      'total_tagihan': total_tagihan_fix,
      'tagihan_per_bulan': tagihan_per_bulan_fix,
      'total_nominal_bayar': total_nominal_bayar_fix,
      'bulan_bayar': bulan_bayar.toStringAsFixed(0),
      'sisa_tagihan': sisa_tagihan_fix,
      'sisa_bulan_bayar': sisa_bulan_bayar.toStringAsFixed(0),
    };

    return ExpansionTile(
      collapsedBackgroundColor: secondaryColor,
      backgroundColor: secondaryColor,
      textColor: blackColor,
      collapsedTextColor: blackColor,
      collapsedIconColor: blackColor,
      iconColor: blackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        widget.transSpp.nama_lengkap,
        style: h4.copyWith(fontWeight: bold),
      ),
      subtitle: Text(
        widget.transSpp.tempat_latihan,
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
            child: (widget.transSpp.transaksi.length > 0)
                ? Column(
                    children: [
                      // ListTile(
                      //   title: Text('Pembayaran Terakhir',
                      //       style: TextStyle(color: blackColor)),
                      //   subtitle:
                      //       Text('${widget.transSpp.transaksi[0].tanggal_bayar}'),
                      //   trailing:
                      //       Text('${nominal_bayar_fix}'), // Ubah warna teks header
                      // ),
                      ListTile(
                        title: Text('Total Bayar',
                            style: TextStyle(color: blackColor)),
                        subtitle: Text('( ${val_bulan_bayar} Bulan ) '),
                        trailing: Text(
                            '${total_nominal_bayar_fix}'), // Ubah warna teks header
                      ),
                      ListTile(
                        title: Text('Sisa Tagihan',
                            style: TextStyle(color: blackColor)),
                        subtitle: Text('( ${val_sisa_bulan_bayar} Bulan )'),
                        trailing: Text(
                            '${sisa_tagihan_fix}'), // Ubah warna teks header
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
                                Get.to(
                                  () => TransSppDetailScreen(
                                      widget.transSpp, informasi_pembayaran),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        title: Text('Belum ada data pembayaran'),
                      ),
                    ],
                  ))
      ],
    );
  }
}

class TransSppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transSpp = sppController.TransSpp;

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
          onRefresh: sppController.getTransSpp,
          child: sppController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: transSpp.length,
                    itemBuilder: (context, index) {
                      final tahun_periode =
                          transSpp[0].transaksi?[0].tahun_periode;
                      final total_tagihan =
                          transSpp[0].transaksi?[0].total_tagihan;
                      final data = transSpp[index];

                      // Render data items
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: MyExpansionTile(
                          transSpp: data,
                          total_tagihan: int.parse(total_tagihan!),
                          tahun_periode: tahun_periode,
                        ),
                      );
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
