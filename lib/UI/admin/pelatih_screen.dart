import 'dart:developer';
import 'dart:math';

import 'package:bipres/UI/admin/pelatih_edit_screen.dart';
import 'package:bipres/controller/Pelatih_controller.dart';
import 'package:bipres/models/Pelatih_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:bipres/shared/theme.dart';

final controller = Get.put(PelatihController());

class MyExpansionTile extends StatefulWidget {
  final pelatih;
  final String namaLengkap, id, idUser;

  MyExpansionTile({
    this.pelatih,
    required this.namaLengkap,
    required this.id,
    required this.idUser,
  });

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  void openDialog(BuildContext context, String id, idUser, nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Pelatih'),
          content: Text('Apakah anda yakin ingin menghapus data ( $nama )?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                controller.deletePelatih(context, id, idUser);
              },
            ),
          ],
        );
      },
    );
  }

  _formattingDate(date) {
    // Parse the original date string to a DateTime object
    DateTime newDate = DateFormat("yyyy-MM-dd").parse(date);

    // Format the DateTime object to the desired format "dd-MMM-yyyy"
    return DateFormat("dd-MMM-yyyy").format(newDate);
  }

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
        widget.namaLengkap,
        style: h4.copyWith(fontWeight: bold),
      ),
      subtitle: Text(
        widget.pelatih.TempatLatihan,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: <Widget>[
        Container(
            color: whiteColorTrans, // Ubah warna latar belakang header
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Username',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.pelatih.username}',
                            style: h5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Jenis Kelamin',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.pelatih.jenisKelamin}',
                            style: h5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Tanggal Lahir',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${_formattingDate(widget.pelatih.tanggalLahir)}',
                            style: h5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Tahun Pengesahan',
                            style: h5,
                          )),
                          Expanded(
                              child: Text(
                            ':   ${widget.pelatih.tahunPengesahan}',
                            style: h5,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Ubah'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          Get.to(() => PelatihEditScreen(widget.pelatih));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: primaryColor,
                        textColor: whiteColor,
                        child: Text('Hapus'),
                        onPressed: () {
                          // Tindakan saat tombol ditekan
                          openDialog(context, widget.id, widget.idUser,
                              widget.namaLengkap);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class PelatihScreen extends StatefulWidget {
  const PelatihScreen({super.key});

  @override
  State<PelatihScreen> createState() => _PelatihScreenState();
}

class _PelatihScreenState extends State<PelatihScreen> {
  final data = controller.pelatih;
  List<PelatihModel> pelatih = <PelatihModel>[];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    pelatih = data;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      pelatih = data
          .where((item) =>
              item.namaLengkap.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.group,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Master Data Pelatih',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getPelatih,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                onChanged: (value) {
                                  filterSearchResults(value);
                                },
                                controller: searchController,
                                decoration: const InputDecoration(
                                  labelText: "Cari nama",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() {
                                searchController.value = TextEditingValue.empty;
                                pelatih = data;
                              })
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            child: const Icon(
                              Icons.refresh,
                              size: 22,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Jumlah pelatih : ${pelatih.length}'),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: pelatih.length,
                          itemBuilder: (context, index) {
                            final data = pelatih[index];

                            // Render data items
                            return Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: MyExpansionTile(
                                  pelatih: data,
                                  namaLengkap: data.namaLengkap,
                                  id: data.id,
                                  idUser: data.idUser,
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.pelatih_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
