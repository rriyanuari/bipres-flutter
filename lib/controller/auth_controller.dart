import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthServices authServices = AuthServices();
  final PrefController prefController = Get.put(PrefController());

  var isLoggedIn = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

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

        // SAVE DATA USER -> PREF
        Map<String, dynamic> dataPref = {
          "id_user": data['id'],
          "username": data['username'],
          "role": data['role'],
        };
        prefController.saveUserPref(dataPref);
        // END SAVE DATA USER

        // SAVE PREF ISLOGGEDIN
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        isLoggedIn.value = true;
        // END SAVE PREF ISLOGGEDIN

        // REDIRECT
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

  Future<void> logout(context) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      isLoggedIn.value = false;

      prefController.clearPref();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berhasil logout, anda akan dialihkan"),
        backgroundColor: Colors.red,
      ));

      await Future.delayed(const Duration(seconds: 2),
          () => Get.offNamed(RouteName.login_screen));
    } finally {
      isLoading.value = false;
      // Get.deleteAll(force: true);
    }
  }

  Future<void> editPassword(
    BuildContext context,
    String? id,
    password_lama,
    password_baru,
  ) async {
    try {
      isLoading.value = true;

      var result =
          await authServices.editPassword(id, password_lama, password_baru);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Perubahan password berhasil'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));

      Future.delayed(const Duration(seconds: 1), () => Get.back());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${error}'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
  }
}
