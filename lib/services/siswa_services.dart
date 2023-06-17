import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SiswaServices {
  var user_key = "portalbipres_api";

  Future<List<SiswaModel>?> getAllSiswa() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListSiswa),
          headers: {
            "user-key": user_key
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<SiswaModel> listSiswa =
            body.map((dynamic item) => SiswaModel.fromJson(item)).toList();

        return listSiswa;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future addSiswa(String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://example.com/api/endpoint'),
        headers: {"user-key": user_key},
        body: {
          'name': name,
          'email': email,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        // Data berhasil dikirim
        Map<String, dynamic> json = convert.jsonDecode(response.body);
        return true;
      } else {
        // Gagal mengirim data
        print('Gagal mengirim data');
        return false;
      }
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
    }
  }
}
