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

void openDialog(BuildContext context, String id, idUser, nama) {
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
              controller.deleteSiswa(id, idUser);
            },
          ),
        ],
      );
    },
  );
}

void _proseshapus(BuildContext context, String id) async {
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
    final siswa = controller.siswa;

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
              'Master Data Siswa',
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
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListTile(
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/defaultProfiPic.png'))),
                                  ),
                                  title: Expanded(
                                    child: Text(
                                      data.namaLengkap,
                                      style: h4.copyWith(fontWeight: regular),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.TempatLatihan,
                                        style: h5.copyWith(fontWeight: regular),
                                      ),
                                      Text(
                                        "${data.Sabuk}",
                                        style: h5.copyWith(fontWeight: regular),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: primaryColor,
                                          ),
                                          onPressed: () {}),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: primaryColor,
                                        ),
                                        onPressed: () {
                                          // dialogHapus(data.id_sekolah.toString());
                                          openDialog(context, data.id,
                                              data.idUser, data.namaLengkap);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));

                      // Co
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.siswa_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
