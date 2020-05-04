import 'dart:convert';
import 'package:http/http.dart' as http;

class Login {
  String token;

  Login({this.token});

  factory Login.createPostResult(Map<String, dynamic> object) {
    return Login(token: object['token']);
  }

  static Future<Login> connectToAPI() async {
    var apiURL ="http://api.sinta.ristekdikti.go.id/consumer/login";

    var apiResult = await http.post(apiURL,
        body: {"username": "lombasinta", "password": "lombasinta123"});

    var jsonObject = json.decode(apiResult.body);
    return Login.createPostResult(jsonObject);
  }
}