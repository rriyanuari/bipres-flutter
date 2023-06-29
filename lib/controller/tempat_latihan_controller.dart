import 'dart:developer';

import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/tempat_latihan_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TempatLatihanController extends GetxController {
  var tempatLatihan = <TempatLatihanModel>[].obs;
  TempatLatihanServices services = TempatLatihanServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getTempatLatihan();
    super.onInit();
  }

  Future<void> getTempatLatihan() async {
    try {
      isLoading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllTempatLatihan();

      if (result != null) {
        tempatLatihan.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addTempatLatihan(
    context,
    String? tempat_latihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.addTempatLatihan(tempat_latihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tempat latihan berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      getTempatLatihan();
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

  Future<void> editTempatLatihan(
    context,
    id,
    tempat_latihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.editTempatLatihan(id, tempat_latihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tempat latihan berhasil diupdate"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      getTempatLatihan();
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

  Future<void> deleteTempatLatihan(context, String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteTempatLatihan(id);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));

      getTempatLatihan();
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
