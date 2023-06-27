import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthServices authServices = AuthServices();
  final PrefController prefController = Get.find<PrefController>();

  RxBool isLoading = false.obs;

  Future<void> login(BuildContext context, username, password) async {
    try {
      isLoading.value = true;

      final response = await authServices.login(username, password);
      String value = response['status'];
      String pesan = response['message'];
      final data = response['data'];

      if (value == 'success') {
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$pesan, anda akan dialihkan'),
          backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
        ));

        Map<String, dynamic> dataPref = {
          "id_user": data['id'],
          "username": data['username'],
          "role": data['role'],
        };

        prefController.savePref(dataPref);
        await Future.delayed(const Duration(seconds: 2),
            () => Get.offNamed(RouteName.main_user_screen));
      } else {
        await Future.delayed(const Duration(seconds: 1));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Username atau password salah'),
          backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
        ));
      }
    } finally {
      isLoading.value = false;
    }
  }
}