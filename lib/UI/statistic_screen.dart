import 'dart:convert';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/kategori_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

    final response = await http.get(Uri.parse(BaseUrl.urlListKategoriStats));

    if (response.contentLength == 2) {
      print(response);
    } else {
      print(response);
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new KategoriStatsModel(
            api['id_kategori_stats'], api['nama_kategori_stats'], api['deskripsi_kategori_stats'], api['log_datetime']);
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
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
                    itemCount: list.length, // list.length
                    itemBuilder: (context, i) {
                      final data = list[i];
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.bar_chart,
                                      color: Color(0xfff009c3d),
                                    ),
                                    title: Text(data.nama_kategori_stats,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xfff009c3d),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.deskripsi_kategori_stats,
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
