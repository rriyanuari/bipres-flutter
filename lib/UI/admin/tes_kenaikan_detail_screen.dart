import 'dart:convert';
import 'dart:developer';

import 'package:bipres/api/api.dart';
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

void openDialog(BuildContext context, String id, tanggal_bayar) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Siswa'),
        content:
            Text('Apakah anda yakin ingin menghapus data ( $tanggal_bayar )?'),
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
              transController.deleteTransSpp(context, id);
            },
          ),
        ],
      );
    },
  );
}

class TesKenaikanDetailScreen extends StatefulWidget {
  @override
  _TesKenaikanDetailScreenState createState() =>
      _TesKenaikanDetailScreenState();
  final SiswaModel data;

  TesKenaikanDetailScreen(this.data);
}

class _TesKenaikanDetailScreenState extends State<TesKenaikanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final siswa = widget.data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              'Detail Kemampuan Siswa',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
            onRefresh: siswaController.getSiswa,
            child: siswaController.isLoading.value
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
                                ':   ${siswa.namaLengkap}',
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
                                ':   ${siswa.TempatLatihan}',
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
                                ':   ${siswa.Sabuk}',
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
                            'Informasi Kemampuan',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Nlai Fisik',
                                style: h5,
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: siswa.NilaiFisik != ""
                                    ? Text(
                                        ':   ${siswa.NilaiFisik}',
                                        style: h5,
                                      )
                                    : Text(
                                        ':   Belum pernah tes',
                                        style: h5,
                                      )),
                          ],
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
                                    siswa.Tingkatan[0]['sikap_pasang_4'] == '0'
                                        ? false
                                        : true,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ],
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
                                    siswa.Tingkatan[0]['sikap_pasang_8'] == '0'
                                        ? false
                                        : true,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ],
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
                                value: siswa.Tingkatan[0]
                                            ['jurus_tangan_kosong'] ==
                                        '0'
                                    ? false
                                    : true,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ],
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
                                value: siswa.Tingkatan[0]
                                            ['jurus_senjata_golok'] ==
                                        '0'
                                    ? false
                                    : true,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ],
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
                                value: siswa.Tingkatan[0]
                                            ['jurus_senjata_toya'] ==
                                        '0'
                                    ? false
                                    : true,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Riwayat Tes Kenaikan Tingkat',
                            style: h4.copyWith(fontWeight: regular),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        siswa.Tes.length > 0
                            ? Expanded(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: siswa.Tes.length,
                                  itemBuilder: (context, index) {
                                    final data = siswa.Tes[index];

                                    var sabuk_awal;
                                    var sabuk_akhir;

                                    switch (data['id_tingkatan_tes']) {
                                      case 2:
                                        setState(() {
                                          sabuk_awal = 'Polos';
                                          sabuk_akhir = 'Jambon';
                                        });

                                        break;
                                      case 3:
                                        setState(() {
                                          sabuk_awal = 'Jambon';
                                          sabuk_akhir = 'Hijau';
                                        });

                                        break;
                                      case 4:
                                        setState(() {
                                          sabuk_awal = 'Hijau';
                                          sabuk_akhir = 'Putih';
                                        });

                                        break;
                                      default:
                                    }

                                    inspect(data);

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
                                                title: Text(
                                                  'Tes kenaikan sabuk: ${data['sabuk']}',
                                                  style: h5.copyWith(
                                                      fontWeight: regular),
                                                ),
                                                subtitle: Text(
                                                  data['tanggal_tes'],
                                                  style: h5.copyWith(
                                                      fontWeight: regular),
                                                ),
                                                trailing: Text(
                                                  '${data['status']}',
                                                  style: h5.copyWith(
                                                      fontWeight: regular),
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: Text('Hasil Tes'),
                                                      content: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Tes kenaikan sabuk',
                                                                  style: h5,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  ':   ${data['sabuk']}',
                                                                  style: h5,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Tanggal tes',
                                                                  style: h5,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  ':   ${data['tanggal_tes']}',
                                                                  style: h5,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Nlai fisik',
                                                                  style: h5,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  ':   ${data['nilai_fisik']}',
                                                                  style: h5,
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
                                                                'Sikap Pasang 1 - 4',
                                                                style: h5,
                                                              )),
                                                              Expanded(
                                                                child: Checkbox(
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  value: data['sikap_pasang_4'] ==
                                                                          '0'
                                                                      ? false
                                                                      : true,
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                            ],
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
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  value: data['sikap_pasang_8'] ==
                                                                          '0'
                                                                      ? false
                                                                      : true,
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                            ],
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
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  value: data['jurus_tangan_kosong'] ==
                                                                          '0'
                                                                      ? false
                                                                      : true,
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                            ],
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
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  value: data['jurus_senjata_golok'] ==
                                                                          '0'
                                                                      ? false
                                                                      : true,
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                            ],
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
                                                                  checkColor:
                                                                      Colors
                                                                          .white,
                                                                  value: data['jurus_senjata_toya'] ==
                                                                          '0'
                                                                      ? false
                                                                      : true,
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ));

                                    // Co
                                  },
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: Text(
                                    '-----   Belum pernah tes   -----',
                                    style: h5.copyWith(fontWeight: regular),
                                  ),
                                ),
                              )
                      ],
                    ),
                  )),
      ),
    );
  }
}
