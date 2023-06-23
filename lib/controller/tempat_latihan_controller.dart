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
    String? tempat_latihan,
  ) async {
    try {
      isLoading.value = true;
      print(isLoading.value);

      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));
      var result = await services.addTempatLatihan(tempat_latihan);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await tempatLatihan();
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

  Future<void> deleteTempatLatihan(String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteTempatLatihan(id);

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
      getTempatLatihan();
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }
}
