import 'dart:convert';
import 'dart:developer';

import 'package:bipres/api/api.dart';
import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/models/spp_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

final siswaController = Get.put(SiswaController());
final transController = Get.put(SppController());
final prefController = Get.put(PrefController());

class TransSppSiswaScreen extends StatefulWidget {
  @override
  _TransSppSiswaScreenState createState() => _TransSppSiswaScreenState();
}

class _TransSppSiswaScreenState extends State<TransSppSiswaScreen> {
  @override
  Widget build(BuildContext context) {
    final siswa = siswaController.siswa;
    final id_user = prefController.myDataPref['id_user'];

    transController.getDetailTransSpp(id_user);

    final transSpp = transController.TransSpp[0];

    // final informasi_pembayaran = widget.informasi_pembayaran;
    inspect(transSpp);

    Future refresh() async {
      await transController.getDetailTransSpp(id_user);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Detail Spp Siswa',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
            onRefresh: refresh,
            child: transController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Informasi Siswa',
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
                                'Nama',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${transSpp.nama_lengkap}',
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
                                'Tempat Latihan',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${transSpp.tempat_latihan}',
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
                                'Sabuk',
                                style: h5.copyWith(fontWeight: regular),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ':   ${transSpp.nama_lengkap}',
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
                            'Informasi Pembayaran',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         'Tahun Periode',
                        //         style: h5.copyWith(fontWeight: regular),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         ':   ${informasi_pembayaran['tahun_periode']}',
                        //         style: h5.copyWith(fontWeight: light),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         'Total Tagihan',
                        //         style: h5.copyWith(fontWeight: regular),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         ':   12 Bulan ( ${informasi_pembayaran['total_tagihan']} )',
                        //         style: h5.copyWith(fontWeight: light),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         'Tagihan /Bulan',
                        //         style: h5.copyWith(fontWeight: regular),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         ':   ${informasi_pembayaran['tagihan_per_bulan']}',
                        //         style: h5.copyWith(fontWeight: light),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         'Total Pembayaran',
                        //         style: h5.copyWith(fontWeight: regular),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         ':   ${informasi_pembayaran['bulan_bayar']} Bulan ( ${informasi_pembayaran['total_nominal_bayar']} )',
                        //         style: h5.copyWith(fontWeight: light),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         'Sisa Tagihan',
                        //         style: h5.copyWith(fontWeight: regular),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         ':   ${informasi_pembayaran['sisa_bulan_bayar']} Bulan ( ${informasi_pembayaran['sisa_tagihan']} )',
                        //         style: h5.copyWith(fontWeight: light),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        (transSpp.transaksi != null)
                            ? Expanded(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: transSpp.transaksi?.length,
                                  itemBuilder: (context, index) {
                                    final data = transSpp.transaksi![index];

                                    // Render data items
                                    return Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        margin: EdgeInsets.only(bottom: 25),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ListTile(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${data.nominal_bayar} ( ${data.tanggal_bayar} )',
                                                      style: h5.copyWith(
                                                          fontWeight: regular),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [],
                                            ),
                                          ],
                                        ));

                                    // Co
                                  },
                                ),
                              )
                            : Text('----- Belum ada transaksi -----')
                      ],
                    ),
                  )),
      ),
    );
  }
}
