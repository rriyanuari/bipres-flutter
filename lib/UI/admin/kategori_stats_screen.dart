import 'dart:convert';

import 'package:bipres/UI/admin/kategoriAdd_screen.dart';
import 'package:bipres/UI/admin/kategoriEdit_screen.dart';
import 'package:bipres/UI/admin/tempat_latihan_add_screen.dart';
import 'package:bipres/api/api.dart';
import 'package:bipres/models/kategori_stats_model.dart';
import 'package:bipres/models/sekolah_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KategoriStatsScreen extends StatefulWidget {
  @override
  State<KategoriStatsScreen> createState() => _KategoriStatsScreen();
}

class _KategoriStatsScreen extends State<KategoriStatsScreen> {
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

    final response = await http.get(Uri.parse(BaseUrl.urlListKategoriStats));

    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new KategoriStatsModel(
            api['id_kategori_stats'],
            api['nama_kategori_stats'],
            api['deskripsi_kategori_stats'],
            api['log_datetime']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id_kategori_stats) async {
    final response = await http.post(Uri.parse(BaseUrl.urlHapusKategoriStats),
        body: {"id_kategori_stats": id_kategori_stats});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ));
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _lihatData();
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ));
    }
  }

  dialogHapus(String id_kategori_stats) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Apakah anda yakin ingin menghapus data ini?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Tidak",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 25.0),
                    InkWell(
                      onTap: () {
                        _proseshapus(id_kategori_stats);
                      },
                      child: Text(
                        "Ya",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ]),
        );
      },
    );
  }

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
              Icon(Icons.category),
              SizedBox(width: 10),
              Text(
                'Kategori Stats',
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.category,
                                        size: 40,
                                      ), // Image.asset("assets/images/logo.png"),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data.nama_kategori_stats,
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
                                          Text(data.deskripsi_kategori_stats),
                                        ],
                                      )),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  kategoriEditScreen(
                                                      data, _lihatData)));
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      dialogHapus(
                                          data.id_kategori_stats.toString());
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
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => kategoriAddScreen(_lihatData)));
        },
        backgroundColor: Color(0xfff009c3d),
        child: const Icon(Icons.add),
      ),
    );
  }
}
