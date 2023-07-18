import 'dart:convert';
import 'dart:developer';

import 'package:bipres/UI/admin/absen_detail_screen.dart';
import 'package:bipres/api/api.dart';
import 'package:bipres/controller/log_absen_controller.dart';
import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/controller/siswa_controller.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:bipres/shared/theme.dart';
import 'package:bipres/shared/loadingWidget.dart';

final logAbsenController = Get.put(LogAbsenController());
final prefController = Get.put(PrefController());

class MyExpansionTile extends StatefulWidget {
  final absen;

  MyExpansionTile({
    required this.absen,
  });

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: secondaryColor,
      backgroundColor: secondaryColor,
      textColor: blackColor,
      collapsedTextColor: blackColor,
      collapsedIconColor: blackColor,
      iconColor: blackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        widget.absen.tanggal_pertemuan,
        style: h4.copyWith(fontWeight: bold),
      ),
      subtitle: Text(
        widget.absen.tempat_latihan,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
    );
  }
}

class SiswaAbsenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogAbsen = logAbsenController.logAbsenSiswa;
    final user = prefController.myDataPref['id_user'];

    inspect(LogAbsen);

    String? pinAbsen;

    final _key = new GlobalKey<FormState>();

    check() {
      final form = _key.currentState;
      if ((form as dynamic).validate()) {
        (form as dynamic).save();
        Navigator.pop(context);
        logAbsenController.addLogAbsen(context, user, pinAbsen);
      }
    }

    void absen() {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Masukan Pin Absen'),
          content: Form(
            key: _key,
            child: TextFormField(
              validator: (e) {
                if ((e as dynamic).isEmpty) {
                  return "Pin absen wajib diisi";
                }
              },
              onSaved: (e) => pinAbsen = e,
              decoration: InputDecoration(labelText: "Pin Absen"),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                check();
                // Navigator.pop(context);
              },
              child: const Text('Absen'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.watch,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Data Absen',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: logAbsenController.getLogAbsenSiswa,
          child: logAbsenController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: LogAbsen.length,
                    itemBuilder: (context, index) {
                      final data = LogAbsen[index];

                      // Render data items
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: LogAbsen.isNotEmpty
                              ? MyExpansionTile(
                                  absen: data,
                                )
                              : Center(
                                  child: Text(
                                      '-----   Belum pernah melakukan absen   -----'),
                                ));

                      // Co
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          absen();
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
