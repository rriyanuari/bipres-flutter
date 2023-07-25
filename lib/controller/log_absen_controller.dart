import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/models/log_absen_model.dart';
import 'package:bipres/services/log_absen_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogAbsenController extends GetxController {
  final prefController = Get.put(PrefController());

  LogAbsenServices services = LogAbsenServices();

  var logAbsen = <AbsenModel>[].obs;
  var logAbsenSiswa = <AbsenSiswaModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getLogAbsen();
    getLogAbsenSiswa();
    super.onInit();
  }

  Future<void> getLogAbsen() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllLogAbsen();

      if (result != null) {
        logAbsen.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> getLogAbsenSiswa() async {
    final user = await prefController.myDataPref['id_user'];
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getLogAbsenSiswa(user);

      if (result != null) {
        logAbsenSiswa.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addJadwalLatihan(
      context, String? id_tempat_latihan, tgl_pertemuan) async {
    try {
      isLoading.value = true;

      var result =
          await services.addJadwalLatihan(id_tempat_latihan, tgl_pertemuan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Tempat latihan berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      getLogAbsen();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
        backgroundColor: Colors.red,
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }

  Future<void> addLogAbsen(context, String? id_siswa, pin_absen) async {
    try {
      isLoading.value = true;

      var result = await services.addLogAbsen(id_siswa, pin_absen);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil melakukan absensi"),
        backgroundColor: Colors.green,
      ));

      // getLogAbsen();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
        backgroundColor: Colors.red,
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }
}
