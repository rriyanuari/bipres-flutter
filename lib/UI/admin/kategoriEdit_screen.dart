import 'dart:convert';
import 'dart:io';
import 'package:bipres/api/api.dart';
import 'package:bipres/models/kategori_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class kategoriEditScreen extends StatefulWidget {
  final VoidCallback reload;
  final KategoriStatsModel model;
  kategoriEditScreen(this.model, this.reload);

  @override
  kategoriEditScreenState createState() => kategoriEditScreenState();
}

class kategoriEditScreenState extends State<kategoriEditScreen> {
  String? nama_kategori_stats; 
  String? deskripsi_kategori_stats;

  TextEditingController? controller_nama_kategori_stats, controller_deskripsi_kategori_stats;


  final _key = new GlobalKey<FormState>();

   setup() async {
    controller_nama_kategori_stats = TextEditingController(text: widget.model.nama_kategori_stats);
    controller_deskripsi_kategori_stats = TextEditingController(text: widget.model.deskripsi_kategori_stats);
  }

  KategoriStatsModel? _currentKategoriStats;
  final String? linkKategoriStats = BaseUrl.urlListKategoriStats;

  Future<List<KategoriStatsModel>> _fetchKategoriStats() async {
    var response = await http.get(Uri.parse(linkKategoriStats.toString()));
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<KategoriStatsModel> listOfKategoriStats = items.map<KategoriStatsModel>((json) {
        return KategoriStatsModel.fromJson(json);
      }).toList();
      return listOfKategoriStats;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlUbahKategoriStats);
      var request = http.MultipartRequest("POST", uri);
      request.fields['id_kategori_stats'] = widget.model.id_kategori_stats!;
      request.fields['nama_kategori_stats'] = nama_kategori_stats!;
      request.fields['deskripsi_kategori_stats'] = deskripsi_kategori_stats!;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data berhasil diubah"), backgroundColor: Color(0xfff009c3d),));
          Future.delayed(
            const Duration(seconds: 2), () {
              setState(() {
                widget.reload();
                Navigator.pop(context);
            });
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data Gagal diubah"), backgroundColor: Colors.red,));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();

    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfff009c3d),
            title: const Text(
              'Edit Kategori Stats',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: controller_nama_kategori_stats,
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi nama kategori stats";
                  }
                },
                onSaved: (e) => nama_kategori_stats = e,
                decoration: InputDecoration(labelText: "Nama kategori stats"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller_deskripsi_kategori_stats,
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi deskripsi kategori stats";
                  }
                },
                onSaved: (e) => deskripsi_kategori_stats = e,
                decoration: InputDecoration(labelText: "Deskripsi kategori stats"),
              ),
              SizedBox(height: 10),
              MaterialButton(
                padding: EdgeInsets.all(10.0),
                color: Color(0xfff009c3d),
                onPressed: () => check(),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
