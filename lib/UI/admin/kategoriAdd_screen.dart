import 'dart:convert';
import 'dart:io';
import 'package:bipres/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class kategoriAddScreen extends StatefulWidget {
  final VoidCallback reload;
  kategoriAddScreen(this.reload);

  @override
  kategoriAddScreenState createState() => kategoriAddScreenState();
}

class kategoriAddScreenState extends State<kategoriAddScreen> {
  String? nama_kategori_stats, deskripsi_kategori_stats;

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    try {
      var uri = Uri.parse(BaseUrl.urlTambahKategoriStats);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_kategori_stats'] = nama_kategori_stats!;
      request.fields['deskripsi_kategori_stats'] = deskripsi_kategori_stats!;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data berhasil ditambahkan"), backgroundColor: Color(0xfff009c3d),));
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
            content: Text("Data Gagal Ditambahkan"), backgroundColor: Colors.red,));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfff009c3d),
            title: const Text(
              'Tambah Kategori Stats',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
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
