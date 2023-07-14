import 'package:bipres/UI/admin/tempat_latihan_edit_screen.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/shared/theme.dart';

class TempatLatihanScreen extends StatefulWidget {
  const TempatLatihanScreen({super.key});

  @override
  State<TempatLatihanScreen> createState() => _TempatLatihanScreenState();
}

class _TempatLatihanScreenState extends State<TempatLatihanScreen> {
  final controller = Get.put(TempatLatihanController());

  void openDialog(BuildContext context, String id, nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Tempat Latihan'),
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
                controller.deleteTempatLatihan(context, id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tempatLatihan = controller.tempatLatihan;

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
              'Master Data Tempat Latihan',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTempatLatihan,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.tempatLatihan.length,
                    itemBuilder: (context, index) {
                      final data = controller.tempatLatihan[index];

                      // Render data items
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(bottom: 25),
                            decoration: BoxDecoration(
                              color: secondarySoftColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.tempatLatihan,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    Get.to(() => TempatLatihanEditScreen(data));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    openDialog(
                                      context,
                                      data.id,
                                      data.tempatLatihan,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.tempat_latihan_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
