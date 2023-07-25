import 'dart:developer';

import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/models/Profile_model.dart';
import 'package:bipres/services/Profile_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final PrefController prefController = Get.put(PrefController());

  var Profile = <ProfileModel>[].obs;
  ProfileServices services = ProfileServices();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    // Get Pref
    final user = prefController.myDataPref;

    try {
      isLoading.value = true;

      var result = await services.getProfile(user['id_user'], user['role']);
      inspect(result);
      if (result != null) {
        Profile.assignAll(result);
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
