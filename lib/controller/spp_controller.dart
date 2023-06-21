import 'dart:developer';

import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:bipres/models/spp_model.dart';
import 'package:bipres/services/spp_services.dart';

class SppController extends GetxController {
  var Spp = <SppModel>[].obs;
  SppServices services = SppServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getSpp();
    super.onInit();
  }

  Future<void> getSpp() async {
    try {
      isLoading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllSpp();

      if (result != null) {
        Spp.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addSpp(
    String? tahun_periode,
    total_tagihan,
  ) async {
    try {
      isLoading.value = true;

      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));
      var result = await services.addSpp(tahun_periode, total_tagihan);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await Spp();
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

  Future<void> deleteSpp(String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteSpp(id);

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
      getSpp();
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', '$error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }
}
