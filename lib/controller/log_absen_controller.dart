import 'dart:developer';

import 'package:bipres/models/log_absen_model.dart';
import 'package:bipres/services/log_absen_services.dart';
import 'package:get/get.dart';

class LogAbsenController extends GetxController {
  var logAbsen = <AbsenModel>[].obs;
  LogAbsenServices services = LogAbsenServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    getLogAbsen();
    super.onInit();
  }

  Future<void> getLogAbsen() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 1));

      var result = await services.getAllLogAbsen();

      if (result != null) {
        logAbsen.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
