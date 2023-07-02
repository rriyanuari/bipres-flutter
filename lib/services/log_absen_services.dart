import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/log_absen_model.dart';
import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LogAbsenServices {
  var user_key = "portalbipres_api";

  Future<List<AbsenModel>?> getAllLogAbsen() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListLogAbsen),
          headers: {
            "user-key": user_key
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        print(body);
        // return null;

        List<AbsenModel> listAbsen =
            body.map((dynamic item) => AbsenModel.fromJson(item)).toList();

        return listAbsen;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future<List<AbsenSiswaModel>?> getLogAbsenSiswa(id_user) async {
    try {
      var body = {
        'id_user': '$id_user',
      };

      var jsonBody = convert.jsonEncode(body);
      final response = await http.post(
        Uri.parse(BaseUrl.urlLogAbsenSiswa),
        body: jsonBody,
        headers: {"user-key": user_key},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        // return null;

        List<AbsenSiswaModel> listAbsen =
            body.map((dynamic item) => AbsenSiswaModel.fromJson(item)).toList();

        return listAbsen;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future addJadwalLatihan(
    String? id_tempat_latihan,
    String? tgl_pertemuan,
  ) async {
    try {
      var body = {
        'id_tempat_latihan': '$id_tempat_latihan',
        'tgl_pertemuan': '$tgl_pertemuan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlAddJadwalAbsen),
        headers: {"user-key": user_key},
        body: jsonBody,
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      Map<String, dynamic> json = convert.jsonDecode(response.body);

      return json;
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
    }
  }

  Future addLogAbsen(
    String? id_siswa,
    String? pin_absen,
  ) async {
    try {
      var body = {
        'id_siswa': '$id_siswa',
        'pin_absen': '$pin_absen',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlAddLogAbsen),
        headers: {"user-key": user_key},
        body: jsonBody,
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      Map<String, dynamic> json = convert.jsonDecode(response.body);

      return json;
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
    }
  }
}
