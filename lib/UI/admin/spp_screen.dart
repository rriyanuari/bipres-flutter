import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/api/api.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/controller/spp_controller.dart';
import 'package:bipres/models/spp_model.dart';

final controller = Get.put(SppController());

void openDialog(BuildContext context, String id, nama) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Spp'),
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
              controller.deleteSpp(id);
            },
          ),
        ],
      );
    },
  );
}

class SppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spp = controller.Spp;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff009c3d),
          title: Row(
            children: [
              Icon(Icons.group),
              SizedBox(width: 10),
              Text(
                'Daftar Master Data SPP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getSpp,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.Spp.length,
                    itemBuilder: (context, index) {
                      final data = controller.Spp[index];

                      // Render data items
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.school,
                                        size: 40,
                                      ), // Image.asset("assets/images/logo.png"),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Tahun ' + data.tahun_periode,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              )),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Total Tagihan ( Rp. ' +
                                                  data.total_tagihan +
                                                  ' )',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      )),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             SppEditScreen(
                                      //                 data, _lihatData)));
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      // dialogHapus(data.id_sekolah.toString());
                                      openDialog(
                                        context,
                                        data.id,
                                        data.tahun_periode,
                                      );
                                    })
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xfff009c3d),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.spp_add_screen);
        },
        backgroundColor: Color(0xfff009c3d),
        child: const Icon(Icons.add),
      ),
    );
  }
}
