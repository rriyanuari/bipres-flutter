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
}
