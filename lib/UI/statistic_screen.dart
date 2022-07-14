import 'dart:convert';

// import 'package:asik/screens/master_data/jabatan/add.dart';
// import 'package:asik/screens/master_data/jabatan/edit.dart';
import 'package:flutter/material.dart';
// import '../../../api/api.dart';
// import '../../../models/jabatan_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

class StatisticScreen extends StatefulWidget {
  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
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
              Icon(Icons.bar_chart),
              SizedBox(width: 10),
              Text(
                'Statistik',
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
                    itemCount: 5, // list.length
                    itemBuilder: (context, i) {
                      // final data = list[i];
                      return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), //color of shadow
                                  spreadRadius: 0.2, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 6)),
                            ],
                          ),
                          child: Card(
                            // color: Color(0xfff009c3d),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.back_hand,
                                      color: Color(0xfff009c3d),
                                    ),
                                    title: Text('Lengan dan Bahu',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xfff009c3d),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Daya tahan otot lengan dan bahu.',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                        Divider(
                                          thickness: 2,
                                          color: Color(0xfff009c3d),
                                        ),
                                        SizedBox(height: 5),
                                        Text("Rank :",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                        SizedBox(height: 5),
                                        Text("1. Usman Sidiq A.",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                        Text("2. Muhammad Algi F.",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                        Text("3. Demian Adlyanata",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xfff009c3d)),
                                          onPressed: () {},
                                          child: Text("Detail")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
          )),
    );
  }
}
