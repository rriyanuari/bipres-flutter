import 'dart:developer';

import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/siswa_services.dart';
import 'package:get/get.dart';

class SiswaController extends GetxController {
  var siswa = <SiswaModel>[].obs;
  SiswaServices services = SiswaServices();
  var loading = true.obs;

  @override
  void onInit() {
    getSiswa();
    super.onInit();
  }

  Future<void> getSiswa() async {
    try {
      loading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllSiswa();

      if (result != null) {
        siswa.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      loading.value = false;
    }
    update();
  }

  Future<void> addSiswa(
      String? nama_depan,
      String? nama_belakang,
      String? nama_lengkap,
      String? jenis_kelamin,
      String? tanggal_lahir,
      String? id_tempat_latihan,
      String? id_tingkatan) async {
    try {
      loading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.addSiswa(
          nama_depan,
          nama_belakang,
          nama_lengkap,
          jenis_kelamin,
          tanggal_lahir,
          id_tempat_latihan,
          id_tingkatan);

      if (!result) {
        throw 'Failed to add data'; // Lemparkan ke error jika result false
      }

      loading.value = false;
      Get.snackbar('Success', 'Data added successfully');
      // Get.off(RouteName.siswa_add_screen);
    } catch (error) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to add data');
    }
    update();
  }
}
