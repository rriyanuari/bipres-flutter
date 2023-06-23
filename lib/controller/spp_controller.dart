import 'dart:developer';

import 'package:bipres/routes/route_name.dart';
import 'package:bipres/shared/theme.dart';
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
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllSpp();

      if (result != null) {
        Spp.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addSpp(
    BuildContext context,
    String? tahun_periode,
    total_tagihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.addSpp(tahun_periode, total_tagihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();
      // await Future.delayed(const Duration(seconds: 2));

      final message = result['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success, ${message}'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));
    } catch (error) {
      await Future.delayed(const Duration(seconds: 1));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed, ${error}'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> editSpp(
    BuildContext context,
    String? id,
    tahun_periode,
    total_tagihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.editSpp(id, tahun_periode, total_tagihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();
      // await Future.delayed(const Duration(seconds: 2));

      final message = result['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success, ${message}'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));
    } catch (error) {
      await Future.delayed(const Duration(seconds: 1));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed, ${error}'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    } finally {
      isLoading.value = false;
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
