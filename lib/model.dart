import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Authors {
  String fullname;

  Authors({this.fullname});

  factory Authors.createAuthor(Map<String, dynamic> object) {
    return Authors(fullname: object["fullname"]);
  }

  static Future<List<Authors>> connectToAPI(
      String token, String halaman) async {
    var apiURL = "http://api.sinta.ristekdikti.go.id/authors?q=" + halaman;
    var apiResult = await http.get(
      apiURL,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listAuthors = (jsonObject as Map<String, dynamic>)['authors'];

    List<Authors> authors = [];
    for (int i = 0; i < listAuthors.length; i++)
      authors.add(Authors.createAuthor(listAuthors[i]));

    return authors;
  }
}

class SearchAuthor {
  String fullname;
  String name;

  SearchAuthor({this.fullname, this.name});

  factory SearchAuthor.createAuthor(Map<String, dynamic> object) {
    return SearchAuthor(fullname: object["fullname"], name: object["affiliation"]["name"]);
  }

 

  static Future<List<SearchAuthor>> connectToAPI(
      String token, String search) async {
    var apiURL = "http://api.sinta.ristekdikti.go.id/authors?q=" + search;
    var apiResult = await http.get(
      apiURL,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listAuthors = (jsonObject as Map<String, dynamic>)['authors'];
    

    List<SearchAuthor> authors = [];

    for (int i = 0; i < listAuthors.length; i++) {
      authors.add(SearchAuthor.createAuthor(listAuthors[i]));
    }

    return authors;
  }
}
