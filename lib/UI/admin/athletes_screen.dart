import 'dart:convert';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/athletes_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AhtletesScreen extends StatefulWidget {
  @override
  State<AhtletesScreen> createState() => _AhtletesScreenState();
}

class _AhtletesScreenState extends State<AhtletesScreen> {
  bool loading = true;

  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = false;
    });

    final response = await http.get(Uri.parse(BaseUrl.urlListAtlet));

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new AthletesModel(
            api['id_user'], 
            api['username'], 
            api['password'],
            api['email'],
            api['status'],
            api['nama_lengkap'],
            api['jenis_kelamin'],
            api['tanggal_lahir'],
            api['id_sekolah'],
            api['log_datetime'],
            );
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  // _proseshapus(String idJabatan) async {
  //   final response = await http.post(Uri.parse(BaseUrl.urlHapusJabatan),
  //       body: {"id_jabatan": idJabatan});
  //   final data = jsonDecode(response.body);
  //   int value = data['success'];
  //   String pesan = data['message'];
  //   if (value == 1) {
  //     setState(() {
  //       Navigator.pop(context);
  //       _lihatData();
  //     });
  //   } else {
  //     print(pesan);
  //   }
  // }

  // dialogHapus(String idJabatan) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: ListView(
  //             padding: EdgeInsets.all(16.0),
  //             shrinkWrap: true,
  //             children: <Widget>[
  //               Text(
  //                 "Apakah anda yakin ingin menghapus data ini?",
  //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 18.0),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text(
  //                       "Tidak",
  //                       style: TextStyle(
  //                           fontSize: 18.0, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   SizedBox(width: 25.0),
  //                   InkWell(
  //                     onTap: () {
  //                       _proseshapus(idJabatan);
  //                     },
  //                     child: Text(
  //                       "Ya",
  //                       style: TextStyle(
  //                           fontSize: 18.0, fontWeight: FontWeight.bold),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ]),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff009c3d),
          title: Row(
            children: [
              Icon(Icons.group),
              SizedBox(width: 10),
              Text(
                'Athletes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list.length, // list.length
                    itemBuilder: (context, i) {
                      final data = list[i];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  size: 40,
                                ), // Image.asset("assets/images/logo.png"),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.nama_lengkap,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfff009c3d),
                                          fontSize: 18,
                                        )),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.tanggal_lahir + " || " + data.jenis_kelamin, style: const TextStyle(
                                          // fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontSize: 15,
                                        )),
                                    Text(data.id_sekolah),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xfff009c3d),
                          ),
                        ],
                      );
                    },
                  ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.athletes_add_screen);
        },
        backgroundColor: Color(0xfff009c3d),
        child: const Icon(Icons.add),
      ),
    );
  }
}
