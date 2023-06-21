import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/spp_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SppServices {
  var user_key = "portalbipres_api";

  Future<List<SppModel>?> getAllSpp() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListSpp), headers: {
        "user-key": user_key
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<SppModel> listSpp =
            body.map((dynamic item) => SppModel.fromJson(item)).toList();

        return listSpp;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future addSpp(String? tahun_periode, total_tagihan) async {
    try {
      var body = {
        'tahun_periode': '$tahun_periode',
        'total_tagihan': '$total_tagihan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlTambahSpp),
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

  Future deleteSpp(String? id) async {
    try {
      var body = {
        'id': '$id',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .delete(
        Uri.parse(BaseUrl.urlHapusSpp),
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
