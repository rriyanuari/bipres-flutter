import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

// import '../../../models/jabatan_model.dart';
// import '../../../api/api.dart';

class sekolahAddScreen extends StatefulWidget {
  @override
  sekolahAddScreenState createState() => sekolahAddScreenState();
}

class sekolahAddScreenState extends State<sekolahAddScreen> {
  String? nama;
  String dropdownValue = 'SMA/SMK';

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proses();
    }
  }

  proses() async {
    // try {
    //   var uri = Uri.parse(BaseUrl.urlTambahJabatan);
    //   var request = http.MultipartRequest("POST", uri);
    //   request.fields['namaJabatan'] = namaJabatan!;

    //   var response = await request.send();
    //   if (response.statusCode > 2) {
    //     if (this.mounted) {
    //       setState(() {
    //         widget.reload();
    //         Navigator.pop(context);
    //       });
    //     }
    //   } else {
    //     print("Data Gagal Ditambahkan");
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
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
                onSaved: (e) => nama = e,
                decoration: InputDecoration(labelText: "Nama Sekolah"),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: (DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
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
