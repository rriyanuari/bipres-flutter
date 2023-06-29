import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TempatLatihanServices {
  var user_key = "portalbipres_api";

  Future<List<TempatLatihanModel>?> getAllTempatLatihan() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urlListTempatLatihan),
          headers: {
            "user-key": user_key
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<TempatLatihanModel> listSiswa = body
            .map((dynamic item) => TempatLatihanModel.fromJson(item))
            .toList();

        return listSiswa;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future addTempatLatihan(String? tempat_latihan) async {
    try {
      var body = {
        'tempat_latihan': '$tempat_latihan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(
        Uri.parse(BaseUrl.urlTambahTempatLatihan),
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

  Future editTempatLatihan(String? id, tempat_latihan) async {
    try {
      var body = {
        'id': '$id',
        'tempat_latihan': '$tempat_latihan',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .put(
        Uri.parse(BaseUrl.urlUbahTempatLatihan),
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

  Future deleteTempatLatihan(String? id) async {
    try {
      var body = {
        'id': '$id',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .delete(
        Uri.parse(BaseUrl.urlHapusTempatLatihan),
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
