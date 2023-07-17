import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:bipres/models/spp_model.dart';
import 'package:bipres/services/spp_services.dart';

class SppController extends GetxController {
  SppServices services = SppServices();
  final prefController = Get.put(PrefController());

  var Spp = <SppModel>[].obs;
  var TransSpp = <TransSppModel>[].obs;
  var DetailTransSpp = <TransSppModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getSpp();
    getTransSpp();
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

  Future<void> getTransSpp() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllTransaksi();

      if (result != null) {
        TransSpp.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> getDetailTransSpp() async {
    try {
      isLoading.value = true;

      final id_user = await prefController.myDataPref['id_user'];

      var result = await services.getDetailTransaksi(id_user);

      if (result != null) {
        DetailTransSpp.assignAll(result);
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Spp berhasil ditambahkan'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));

      getSpp();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed, ${error}'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Spp berhasil diupdate'),
        backgroundColor: Colors.green, // Ganti dengan warna yang diinginkan
      ));

      getSpp();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed, ${error}'),
        backgroundColor: Colors.red, // Ganti dengan warna yang diinginkan
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }

  Future<void> deleteSpp(context, String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteSpp(id);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));

      getSpp();
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

  Future<void> deleteTransSpp(context, String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteTransaksiSpp(id);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));
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

  Future<void> addTransaksiSpp(
    context,
    String? id_siswa,
    id_spp,
    nominal_bayar,
  ) async {
    try {
      isLoading.value = true;

      var result =
          await services.addTransaksiSpp(id_siswa, id_spp, nominal_bayar);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berhasil melakukan absensi"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      getSpp();
    } catch (error) {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
