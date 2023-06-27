import 'dart:async';

import 'package:bipres/api/api.dart';
import 'package:bipres/models/Profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProfileServices {
  var user_key = "portalbipres_api";

  Future<List<ProfileModel>?> getProfile(String idUser, role) async {
    try {
      var body = {
        'id_user': '$idUser',
        'table_role': '$role',
      };
      var jsonBody = convert.jsonEncode(body);

      final response = await http
          .post(Uri.parse('https://bipres.holtechno.space/api/profile.php'),
              headers: {"user-key": user_key}, body: jsonBody)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try again");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = convert.jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<ProfileModel> profile =
            body.map((dynamic item) => ProfileModel.fromJson(item)).toList();

        return profile;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
