import 'dart:developer';

import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:bipres/models/tingkatan_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/tempat_latihan_services.dart';
import 'package:bipres/services/tingkatan_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TingkatanController extends GetxController {
  var tingkatan = <TingkatanModel>[].obs;
  TingkatanServices services = TingkatanServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getTingkatan();
    super.onInit();
  }

  Future<void> getTingkatan() async {
    try {
      isLoading.value = true;
      // Simulasi penundaan untuk pemanggilan data
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllTingkatan();

      if (result != null) {
        tingkatan.assignAll(result);
        // print("data siswa: ${siswa.length}");
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
