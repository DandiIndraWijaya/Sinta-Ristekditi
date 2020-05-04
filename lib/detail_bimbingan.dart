import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Rama extends StatefulWidget {
  final String data;
  final String data2;

  Rama({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _RamaState createState() => _RamaState();
}

class _RamaState extends State<Rama> {
  connectToAPI(String id, String token) async {
    var apiURL =
        "http://api.sinta.ristekdikti.go.id/author/detail/bimbingan/54481";
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
    return  Scaffold(
        appBar: AppBar(
          title: Text('Rama Documents'),
        ),
        body: FutureBuilder(
            future: connectToAPI(widget.data, widget.data2),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 100.0,
                            color: Colors.lightBlue[100]));
                case ConnectionState.active:

                case ConnectionState.waiting:
                  return Center(child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 100.0,
                            color: Colors.lightBlue[100]));
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    var article =
                        snapshot.data['author']['bimbingan']['article'];
                    return ListView.builder(
                        itemCount: article.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                title: Text(
                                  article[index]['dc_title'],
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Text(article[index]['dc_subject'])
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
