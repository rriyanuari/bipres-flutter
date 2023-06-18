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

void openDialog(BuildContext context, String id, nama) {
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
              _proseshapus(context, id);
            },
          ),
        ],
      );
    },
  );
}

_proseshapus(BuildContext context, String id) async {
  var body = {
    'id': '$id',
  };
  var jsonBody = convert.jsonEncode(body);

  final response = await http.delete(Uri.parse(BaseUrl.urlHapusSiswa),
      headers: {"user-key": "portalbipres_api"}, body: jsonBody);
  final data = jsonDecode(response.body);
  String status = data['status'];
  String message = data['message'];
  if (status == 'success') {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
    Future.delayed(const Duration(seconds: 1), () {
      // setState(() {
      //   _lihatData();
      // });
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}

class SiswaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SiswaController());
    final siswa = controller.siswa;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff009c3d),
          title: Row(
            children: [
              Icon(Icons.group),
              SizedBox(width: 10),
              Text(
                'Daftar Siswa',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getSiswa,
          child: controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.siswa.length,
                    itemBuilder: (context, index) {
                      final data = controller.siswa[index];

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
                                          Text(data.namaLengkap,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.tanggalLahir),
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
                                          context, data.id, data.namaLengkap);
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
          Get.toNamed(RouteName.siswa_add_screen);
        },
        backgroundColor: Color(0xfff009c3d),
        child: const Icon(Icons.add),
      ),
    );
  }
}
