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

  Future addSiswa(
      String? nama_depan,
      String? nama_belakang,
      String? nama_lengkap,
      String? jenis_kelamin,
      String? tanggal_lahir,
      String? id_tempat_latihan,
      String? id_tingkatan) async {
    try {
      var body = {
        'nama_depan': '$nama_depan',
        'nama_belakang': '$nama_belakang',
        'nama_lengkap': '$nama_lengkap',
        'jenis_kelamin': '$jenis_kelamin',
        'tanggal_lahir': '$tanggal_lahir',
        'id_tempat_latihan': '$id_tempat_latihan',
        'id_tingkatan': '$id_tingkatan'
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlTambahSiswa),
        headers: {"user-key": user_key},
        body: jsonBody,
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode != 200) {
        // Data berhasil dikirim
        print('Gagal mengirim data');
        print(response.body);
        print(jsonBody);
        return false;
      }
      print(response.statusCode);
      Map<String, dynamic> json = convert.jsonDecode(response.body);
      return true;
    } catch (e) {
      // Error saat mengirim data
      print('Error: $e');
    }
  }
}
