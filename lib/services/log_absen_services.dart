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
}
