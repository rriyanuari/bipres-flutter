import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefController extends GetxController {
  var myDataPref = {}.obs;

  @override
  void onInit() {
    getPref();
    super.onInit();
  }

  void getPref() async {
    print('function getpref running');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('myDataPrefController');
    if (data != null) {
      Map<dynamic, dynamic> map = jsonDecode(data);

      myDataPref.value = Map<dynamic, dynamic>.from(map);
    }
  }

  void saveUserPref(Map<dynamic, dynamic> newData) async {
    print('function savepref running');

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
