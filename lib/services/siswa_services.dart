import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/siswa_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SiswaServices {
  // var path = "https://newsapi.org/v2/top-headlines?";
  // var country = "id";
  var user_key = "portalbipres_api";

  Future<List<SiswaModel>?> getAllSiswa() async {
    try {
      final response = await http.get(
          Uri.parse("https://bipres.holtechno.space/api/siswa/list.php"),
          headers: {
            "user-key": "portalbipres_api"
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
}
