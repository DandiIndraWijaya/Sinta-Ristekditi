import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListAuthors extends StatefulWidget {
  final String data;

  ListAuthors({
    Key key,
    @required this.data,
  }) : super(key: key);
  @override
  _ListAuthorsState createState() => _ListAuthorsState();
}

class _ListAuthorsState extends State<ListAuthors> {
  connectToAPI(String token) async {
    var apiURL = "http://api.sinta.ristekdikti.go.id/authors";
    var apiResult = await http.get(
      apiURL,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
    );
    return jsonDecode(apiResult.body);
    // return Author.createAuthor(jsonObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors'),
      ),
      body: FutureBuilder(
          future: connectToAPI(widget.data),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('none');
              case ConnectionState.active:

              case ConnectionState.waiting:
                return Text('tunggu');
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var authors = snapshot.data['authors'];
                  return ListView.builder(
                      itemCount: authors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(authors[index]['fullname']),
                            subtitle: Text(authors[index]['affiliation']['name']),
                          ),
                        );
                      });
                } else {
                  return Text('error');
                }
            }
          }),
    );
  }
}
