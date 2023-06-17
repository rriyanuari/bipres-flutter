import 'dart:developer';

import 'package:bipres/models/siswa_model.dart';
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

  Future<void> addSiswa() async {
    try {
      loading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.addSiswa;

      if (result == true) {
        // siswa.assignAll(result);
        print('Siswa berhasil ditambahkan');
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      loading.value = false;
    }
    update();
  }
}
