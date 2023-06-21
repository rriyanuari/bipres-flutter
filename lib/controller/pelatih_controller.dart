import 'dart:developer';

import 'package:bipres/models/Pelatih_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/Pelatih_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PelatihController extends GetxController {
  var pelatih = <PelatihModel>[].obs;
  PelatihServices services = PelatihServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getPelatih();
    super.onInit();
  }

  Future<void> getPelatih() async {
    try {
      isLoading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllPelatih();

      if (result != null) {
        pelatih.assignAll(result);
        // print("data Pelatih: ${Pelatih.length}");
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addPelatih(
    String? nama_depan,
    String? nama_belakang,
    String? nama_lengkap,
    String? jenis_kelamin,
    String? tanggal_lahir,
    String? tahun_pengesahan,
    String? id_tempat_latihan,
  ) async {
    try {
      isLoading.value = true;
      print(isLoading.value);

      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));
      var result = await services.addPelatih(
        nama_depan,
        nama_belakang,
        nama_lengkap,
        jenis_kelamin,
        tanggal_lahir,
        tahun_pengesahan,
        id_tempat_latihan,
      );

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await getPelatih();
      Get.back();

      final message = result['message'];
      Get.snackbar(
        'Success',
        '$message',
        backgroundColor: Color(0xFF98B66E),
      );
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }

  Future<void> deletePelatih(String? id, id_user) async {
    try {
      isLoading.value = true;

      var result = await services.deletePelatih(id, id_user);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      final message = result['message'];

      Get.back();

      Get.snackbar(
        'Success',
        '$message',
        backgroundColor: Color(0xFF98B66E),
      );

      isLoading.value = false;
      getPelatih();
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }
}
