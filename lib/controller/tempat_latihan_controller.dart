import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/services/tempat_latihan_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TempatLatihanController extends GetxController {
  TempatLatihanServices services = TempatLatihanServices();

  var tempatLatihan = <TempatLatihanModel>[].obs;
  var tempatLatihanItems = <DropdownMenuItem<String>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getTempatLatihan();
    super.onInit();
  }

  Future<void> getTempatLatihan() async {
    print('loaded');

    try {
      isLoading.value = true;

      var result = await services.getAllTempatLatihan();

      if (result != null) {
        tempatLatihan.assignAll(result);

        // Konversi hasil data menjadi DropdownMenuItem
        tempatLatihanItems.value = result.map((item) {
          return DropdownMenuItem(
            value: item.id,
            child: Text(item.tempatLatihan),
          );
        }).toList();

        // Set index pertama item
        tempatLatihanItems.insert(
          0,
          DropdownMenuItem(
            value: "",
            child: Text("Pilih Tempat Latihan"),
          ),
        );
      } else {
        print("null");
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> addTempatLatihan(
    context,
    String? tempat_latihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.addTempatLatihan(tempat_latihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tempat latihan berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back())
          .then((val) => getTempatLatihan());
    } catch (error) {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }

  Future<void> editTempatLatihan(
    context,
    id,
    tempat_latihan,
  ) async {
    try {
      isLoading.value = true;

      var result = await services.editTempatLatihan(id, tempat_latihan);
      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tempat latihan berhasil diupdate"),
        backgroundColor: Colors.green,
      ));

      await Future.delayed(const Duration(seconds: 1), () => Get.back());

      getTempatLatihan();
    } catch (error) {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
      ));
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
    update();
  }

  Future<void> deleteTempatLatihan(context, String? id) async {
    try {
      isLoading.value = true;

      var result = await services.deleteTempatLatihan(id);

      if (result['status'] == 'error') {
        // Lemparkan ke error jika result false
        throw result['message'];
      }
      Get.back();

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data berhasil dihapus"),
        backgroundColor: Colors.green,
      ));

      getTempatLatihan();
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

  void dropDownList() {
    // Ambil data dari API atau sumber data lainnya
    // Simpan data ke dalam variabel tempatLatihanItems

    tempatLatihanItems.value = [
      DropdownMenuItem(value: "", child: Text("Pilih Tempat Latihan")),
      DropdownMenuItem(value: "1", child: Text("SMK Al-Hikmah")),
      DropdownMenuItem(value: "2", child: Text("SMPN 2 Curug")),
    ];
  }
}
