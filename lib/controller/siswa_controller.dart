import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/siswa_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SiswaController extends GetxController {
  SiswaServices services = SiswaServices();
  final userController = Get.put(PrefController());

  var siswa = <SiswaModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getSiswaWithTingkatan();
    super.onInit();
  }

  Future<void> getSiswa() async {
    try {
      isLoading.value = true;

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

  Future<void> getSiswaWithTingkatan() async {
    try {
      // isLoading.value = true;

      var result = await services.getAllSiswaWithTingkatan();

      if (result != null) {
        siswa.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      // isLoading.value = false;
    }
    update();
  }

  Future<void> addSiswa(
      context,
      String? nama_depan,
      String? nama_belakang,
      String? nama_lengkap,
      String? jenis_kelamin,
      String? tanggal_lahir,
      String? id_tempat_latihan,
      String? id_tingkatan) async {
    try {
      isLoading.value = true;

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

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Pelatih berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      await getSiswa();
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

  Future<void> editSiswa(
      context,
      String? id,
      String? nama_depan,
      String? nama_belakang,
      String? nama_lengkap,
      String? jenis_kelamin,
      String? tanggal_lahir,
      String? id_tempat_latihan,
      String? id_tingkatan) async {
    try {
      final id_user = userController.myDataPref['id_user'];

      isLoading.value = true;

      var result = await services.editSiswa(
          id,
          id_user,
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

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Pelatih berhasil diupdate"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      await getSiswa();
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

  Future<void> deleteSiswa(context, String? id, id_user) async {
    try {
      isLoading.value = true;

      var result = await services.deleteSiswa(id, id_user);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      final message = result['message'];

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));

      getSiswa();
    } catch (error) {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data gagal dihapus"),
        backgroundColor: Colors.red,
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }
}
