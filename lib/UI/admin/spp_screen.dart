import 'package:bipres/UI/admin/spp_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bipres/routes/route_name.dart';
import 'package:bipres/controller/spp_controller.dart';

import 'package:bipres/shared/theme.dart';

final controller = Get.put(SppController());

void openDialog(BuildContext context, String id, nama) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus Spp'),
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
              controller.deleteSpp(id);
            },
          ),
        ],
      );
    },
  );
}

class SppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controller.getSpp();
    final spp = controller.Spp;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(
              Icons.monetization_on,
              size: 24,
            ),
            SizedBox(width: 20),
            Text(
              'Master Data SPP',
              style: h4.copyWith(fontWeight: bold),
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getSpp,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.Spp.length,
                    itemBuilder: (context, index) {
                      final data = controller.Spp[index];

                      // Render data items
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tahun ' + data.tahun_periode,
                                            style:
                                                h4.copyWith(fontWeight: bold),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Tagihan ( Rp. ' +
                                                data.total_tagihan +
                                                ' )',
                                            style: h5.copyWith(
                                                fontWeight: regular),
                                          ),
                                        ],
                                      )),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      Get.to(() => SppEditScreen(data));
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      // dialogHapus(data.id_sekolah.toString());
                                      openDialog(
                                        context,
                                        data.id,
                                        data.tahun_periode,
                                      );
                                    })
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: primaryColor,
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
          Get.toNamed(RouteName.spp_add_screen);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
