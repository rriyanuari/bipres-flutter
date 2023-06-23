import 'dart:developer';

import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/siswa_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SiswaController extends GetxController {
  var siswa = <SiswaModel>[].obs;
  SiswaServices services = SiswaServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getSiswa();
    super.onInit();
  }

  Future<void> getSiswa() async {
    try {
      isLoading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllSiswa();

      if (result != null) {
        siswa.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addSiswa(
      String? nama_depan,
      String? nama_belakang,
      String? nama_lengkap,
      String? jenis_kelamin,
      String? tanggal_lahir,
      String? id_tempat_latihan,
      String? id_tingkatan) async {
    try {
      isLoading.value = true;
      print(isLoading.value);

      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));
      var result = await services.addSiswa(
          nama_depan,
          nama_belakang,
          nama_lengkap,
          jenis_kelamin,
          tanggal_lahir,
          id_tempat_latihan,
          id_tingkatan);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await getSiswa();
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

  Future<void> deleteSiswa(String? id, id_user) async {
    try {
      isLoading.value = true;

      // Simulasi penundaan untuk pemanggilan data
      // await Future.delayed(Duration(seconds: 1));

      var result = await services.deleteSiswa(id, id_user);

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
      getSiswa();
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }
}
