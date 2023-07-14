import 'dart:async';
import 'dart:developer';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/Pelatih_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PelatihServices {
  var user_key = "portalbipres_api";

  Future<List<PelatihModel>?> getAllPelatih() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListPelatih),
          headers: {
            "user-key": user_key
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<PelatihModel> listPelatih =
            body.map((dynamic item) => PelatihModel.fromJson(item)).toList();

        return listPelatih;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future addPelatih(
    String? nama_depan,
    String? nama_belakang,
    String? nama_lengkap,
    String? jenis_kelamin,
    String? tanggal_lahir,
    String? tahun_pengesahan,
    String? id_tempat_latihan,
  ) async {
    try {
      var body = {
        'nama_depan': '$nama_depan',
        'nama_belakang': '$nama_belakang',
        'nama_lengkap': '$nama_lengkap',
        'jenis_kelamin': '$jenis_kelamin',
        'tanggal_lahir': '$tanggal_lahir',
        'tahun_pengesahan': '$tahun_pengesahan',
        'id_tempat_latihan': '$id_tempat_latihan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlTambahPelatih),
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

  Future editPelatih(
    String? id,
    String? nama_depan,
    String? nama_belakang,
    String? nama_lengkap,
    String? jenis_kelamin,
    String? tanggal_lahir,
    String? tahun_pengesahan,
    String? id_tempat_latihan,
  ) async {
    try {
      var body = {
        'id': '$id',
        'nama_depan': '$nama_depan',
        'nama_belakang': '$nama_belakang',
        'nama_lengkap': '$nama_lengkap',
        'jenis_kelamin': '$jenis_kelamin',
        'tanggal_lahir': '$tanggal_lahir',
        'tahun_pengesahan': '$tahun_pengesahan',
        'id_tempat_latihan': '$id_tempat_latihan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .put(
        Uri.parse(BaseUrl.urlUbahPelatih),
        headers: {"user-key": user_key},
        body: jsonBody,
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      Map<String, dynamic> json = convert.jsonDecode(response.body);

      inspect(response.body);

      return json;
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
    }
  }

  Future deletePelatih(String? id, id_user) async {
    try {
      var body = {
        'id': '$id',
        'id_user': '$id_user',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .delete(
        Uri.parse(BaseUrl.urlHapusPelatih),
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
