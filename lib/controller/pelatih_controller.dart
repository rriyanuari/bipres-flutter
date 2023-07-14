import 'dart:developer';

import 'package:bipres/models/Pelatih_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/Pelatih_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PelatihController extends GetxController {
  PelatihServices services = PelatihServices();

  var pelatih = <PelatihModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getPelatih();
    super.onInit();
  }

  Future<void> getPelatih() async {
    try {
      isLoading.value = true;

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
    context,
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

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Pelatih berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      await getPelatih();
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

  Future<void> editPelatih(
    context,
    String? id,
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

      var result = await services.editPelatih(
        id,
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

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Pelatih berhasil diupdate"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back())
          .then((val) => getPelatih());
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

  Future<void> deletePelatih(context, String? id, id_user) async {
    try {
      isLoading.value = true;

      var result = await services.deletePelatih(id, id_user);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      Get.back();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));

      getPelatih();
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
