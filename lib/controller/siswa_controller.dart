import 'dart:developer';

import 'package:bipres/models/siswa_model.dart';
import 'package:bipres/services/siswa_services.dart';
import 'package:get/get.dart';

class SiswaController extends GetxController {
  var siswa = <SiswaModel>[].obs;
  SiswaServices services = SiswaServices();
  var getLoading = true.obs;

  @override
  void onInit() {
    getSiswa();
    super.onInit();
  }

  Future<void> getSiswa() async {
    try {
      getLoading.value = true;
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
      getLoading.value = false;
    }
    update();
  }
}
