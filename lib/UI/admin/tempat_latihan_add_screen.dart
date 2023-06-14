import 'dart:convert';
import 'dart:io';
import 'package:bipres/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class TempatLatihanAddScreen extends StatefulWidget {
  // final VoidCallback reload;
  // TempatLatihanAddScreen(this.reload);

  @override
  TempatLatihanAddScreenState createState() => TempatLatihanAddScreenState();
}

class TempatLatihanAddScreenState extends State<TempatLatihanAddScreen> {
  String? nama_sekolah;
  String jenjang_sekolah = 'SMA/SMK';

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
      var uri = Uri.parse(BaseUrl.urlTambahSekolah);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_sekolah'] = nama_sekolah!;
      request.fields['jenjang_sekolah'] = jenjang_sekolah;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data berhasil ditambahkan"),
            backgroundColor: Color(0xfff009c3d),
          ));
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              // widget.reload();
              Navigator.pop(context);
            });
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Data Gagal Ditambahkan"),
          backgroundColor: Colors.red,
        ));
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
              'Tambah Sekolah',
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
                    return "Silahkan isi nama sekolah";
                  }
                },
                onSaved: (e) => nama_sekolah = e,
                decoration: InputDecoration(labelText: "Nama Sekolah"),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: (DropdownButton<String>(
                  value: jenjang_sekolah,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      jenjang_sekolah = newValue!;
                    });
                  },
                  items: <String>['SMA/SMK', 'SMP', 'SD']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
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
