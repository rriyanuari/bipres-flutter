import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefController extends GetxController {
  RxMap<dynamic, dynamic> myDataPref = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getPref();
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('myDataPrefController');
    if (data != null) {
      Map<dynamic, dynamic> map = jsonDecode(data);
      myDataPref.value = Map<dynamic, dynamic>.from(map);
    }
  }

  void savePref(Map<dynamic, dynamic> newData) async {
    myDataPref.value = newData;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myDataPrefController', jsonEncode(newData));
  }

  void clearPref() async {
    myDataPref.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('myDataPrefController');
  }
}
