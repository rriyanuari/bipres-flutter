import 'dart:convert';

// import 'package:asik/screens/master_data/jabatan/add.dart';
// import 'package:asik/screens/master_data/jabatan/edit.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../api/api.dart';
// import '../../../models/jabatan_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

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

    // final response = await http.get(Uri.parse(BaseUrl.urlListJabatan));

    // if (response.contentLength == 2) {
    //   print(response);
    // } else {
    //   print(response);
    //   final data = jsonDecode(response.body);
    //   data.forEach((api) {
    //     final ab = new JabatanModel(
    //         api['id_jabatan'], api['nama_jabatan'], api['log_datetime']);
    //     list.add(ab);
    //   });

    //   setState(() {
    //     loading = false;
    //   });
    // }
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
    Widget _item(data) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.amber[100],
          child: Row(children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(data.idJabatan + ".     "),
                  Text(data.namaJabatan),
                ],
              ),
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => EditJabatan(data, _lihatData)));
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // dialogHapus(data.idJabatan.toString());
                }),
          ]));
    }

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
                    itemCount: 2, // list.length
                    itemBuilder: (context, i) {
                      // final data = list[i];
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
                                    Text("Usman Sidiq A.",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        )),
                                    Text(
                                      "( Putra )",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2009"),
                                    Text("MTS - Al Hikmah Curug"),
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
