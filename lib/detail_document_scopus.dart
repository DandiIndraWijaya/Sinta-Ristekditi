import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class DocumentScopus extends StatefulWidget {
  final String data;
  final String data2;

  DocumentScopus({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _DocumentScopusState createState() => _DocumentScopusState();
}

class _DocumentScopusState extends State<DocumentScopus> {
  connectToAPI(String id, String token) async {
    var apiURL =
        "http://api.sinta.ristekdikti.go.id/author/detail/scopus/" + id;
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
    return 
       Scaffold(
        appBar: AppBar(
          title: Text('Documents Scopus'),
        ),
        body: FutureBuilder(
            future: connectToAPI(widget.data, widget.data2),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.active:

                case ConnectionState.waiting:
                  return Center(child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 100.0,
                            color: Colors.lightBlue[100]));
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    var article = snapshot.data['author']['scopus']['article'];
                    return ListView.builder(
                        itemCount: article.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                leading: Text('Q' + article[index]['quartile'],
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.grey)),
                                title: Text(
                                  article[index]['title'],
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Text(article[index]['publicationName'] +
                                        " | " +
                                        "vol: " +
                                        article[index]['volume'] +
                                        " | " +
                                        article[index]['coverDate'] +
                                        " | " +
                                        article[index]['aggregationType'])
                                  ],
                                )),
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
