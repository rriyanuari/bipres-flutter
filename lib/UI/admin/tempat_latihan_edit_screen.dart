import 'dart:convert';
import 'dart:io';
import 'package:bipres/api/api.dart';
import 'package:bipres/models/sekolah_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class TempatLatihanEditScreen extends StatefulWidget {
  // final VoidCallback reload;
  // final SekolahModel model;
  // TempatLatihanEditScreen(this.model, this.reload);

  @override
  TempatLatihanEditScreenState createState() => TempatLatihanEditScreenState();
}

class TempatLatihanEditScreenState extends State<TempatLatihanEditScreen> {
  String? nama_sekolah;
  String? jenjang_sekolah = 'SMA/SMK';

  TextEditingController? controller_nama_sekolah;

  final _key = new GlobalKey<FormState>();

  // setup() async {
  //   controller_nama_sekolah =
  //       TextEditingController(text: widget.model.nama_sekolah);
  //   jenjang_sekolah = widget.model.jenjang_sekolah;
  // }

  SekolahModel? _currentSekolah;
  final String? linkSekolah = BaseUrl.urlListSekolah;

  Future<List<SekolahModel>> _fetchSekolah() async {
    var response = await http.get(Uri.parse(linkSekolah.toString()));
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<SekolahModel> listOfSekolah = items.map<SekolahModel>((json) {
        return SekolahModel.fromJson(json);
      }).toList();
      return listOfSekolah;
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
      var uri = Uri.parse(BaseUrl.urlUbahSekolah);
      var request = http.MultipartRequest("POST", uri);
      // request.fields['id_sekolah'] = widget.model.id_sekolah!;
      // request.fields['nama_sekolah'] = nama_sekolah!;
      // request.fields['jenjang_sekolah'] = jenjang_sekolah!;

      var response = await request.send();
      if (response.statusCode > 2) {
        if (this.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data berhasil diubah"),
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
          content: Text("Data Gagal diubah"),
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

    // setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfff009c3d),
            title: const Text(
              'Edit Sekolah',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: controller_nama_sekolah,
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
