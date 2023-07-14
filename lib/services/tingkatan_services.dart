import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/tingkatan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TingkatanServices {
  var user_key = "portalbipres_api";

  Future<List<TingkatanModel>?> getAllTingkatan() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListTingkatan),
          headers: {
            "user-key": user_key
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<TingkatanModel> listTingkatan =
            body.map((dynamic item) => TingkatanModel.fromJson(item)).toList();

        return listTingkatan;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future testKenaikan(
      String? id_siswa,
      String? id_tingkatan,
      String? nilai_fisik,
      String? sikap_pasang_4,
      String? sikap_pasang_8,
      String? jurus_tangan_kosong,
      String? jurus_senjata_golok,
      String? jurus_senjata_toya) async {
    try {
      var body = {
        "id_siswa": id_siswa,
        "id_tingkatan": id_tingkatan,
        "nilai_fisik": nilai_fisik,
        "sikap_pasang_4": sikap_pasang_4,
        "sikap_pasang_8": sikap_pasang_8,
        "jurus_tangan_kosong": jurus_tangan_kosong,
        "jurus_senjata_golok": jurus_senjata_golok,
        "jurus_senjata_toya": jurus_senjata_toya
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlAddTesKenaikan),
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
