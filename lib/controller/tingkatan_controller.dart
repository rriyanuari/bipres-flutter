import 'dart:developer';

import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:bipres/models/tingkatan_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/tempat_latihan_services.dart';
import 'package:bipres/services/tingkatan_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TingkatanController extends GetxController {
  TingkatanServices services = TingkatanServices();

  var tingkatan = <TingkatanModel>[].obs;
  var tingkatanItems = <DropdownMenuItem<String>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getTingkatan();
    super.onInit();
  }

  Future<void> getTingkatan() async {
    try {
      isLoading.value = true;

      var result = await services.getAllTingkatan();

      if (result != null) {
        tingkatan.assignAll(result);

        // Konversi hasil data menjadi DropdownMenuItem
        tingkatanItems.value = result.map((item) {
          return DropdownMenuItem(
            value: item.id,
            child: Text(item.sabuk),
          );
        }).toList();

        // Set index pertama item
        tingkatanItems.insert(
          0,
          DropdownMenuItem(
            value: "",
            child: Text("Pilih Tingkatan"),
          ),
        );
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addTestKenaikan(
      context,
      String? id_siswa,
      String? id_tingkatan,
      String? nilai_fisik,
      String? sikap_pasang_4,
      String? sikap_pasang_8,
      String? jurus_tangan_kosong,
      String? jurus_senjata_golok,
      String? jurus_senjata_toya) async {
    try {
      isLoading.value = true;

      var result = await services.testKenaikan(
        id_siswa,
        id_tingkatan,
        nilai_fisik,
        sikap_pasang_4,
        sikap_pasang_8,
        jurus_tangan_kosong,
        jurus_senjata_golok,
        jurus_senjata_toya,
      );

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data kenaikan tingkat berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      // await getSiswa();
    } catch (error) {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }
}
