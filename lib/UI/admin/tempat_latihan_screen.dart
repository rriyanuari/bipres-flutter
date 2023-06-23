import 'dart:convert';

import 'package:bipres/api/api.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

final controller = Get.put(TempatLatihanController());

void openDialog(BuildContext context, String id, nama) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Tempat Latihan'),
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
              controller.deleteTempatLatihan(id);
            },
          ),
        ],
      );
    },
  );
}

class TempatLatihanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tempatLatihan = controller.tempatLatihan;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff009c3d),
          title: Row(
            children: [
              Icon(Icons.group),
              SizedBox(width: 10),
              Text(
                'Daftar Tempat Latihan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTempatLatihan,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.tempatLatihan.length,
                    itemBuilder: (context, index) {
                      final data = controller.tempatLatihan[index];

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
                                        Text(data.tempatLatihan,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
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
                                      //             TempatLatihanEditScreen(
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
                                        data.tempatLatihan,
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
          Get.toNamed(RouteName.tempat_latihan_add_screen);
        },
        backgroundColor: Color(0xfff009c3d),
        child: const Icon(Icons.add),
      ),
    );
  }
}
