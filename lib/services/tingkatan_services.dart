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
}
