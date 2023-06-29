import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/tempat_latihan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthServices {
  var user_key = "portalbipres_api";

  Future<Map<String, dynamic>> login(
      String inputUsername, String inputPassword) async {
    final response = await http.post(
      Uri.parse(BaseUrl.urlLogin),
      headers: {"user-key": "portalbipres_api"},
      body: convert
          .jsonEncode({"username": inputUsername, "password": inputPassword}),
    );

    final responseDecode = convert.jsonDecode(response.body);
    return responseDecode;
  }

  Future editPassword(String? id, password_lama, password_baru) async {
    try {
      var body = {
        'id': '$id',
        'password_lama': '$password_lama',
        'password_baru': '$password_baru',
      };

      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .put(
        Uri.parse(BaseUrl.urlUbahPassword),
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
