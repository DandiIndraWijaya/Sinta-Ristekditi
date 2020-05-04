import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Research extends StatefulWidget {
  final String data;
  final String data2;

  Research({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _ResearchState createState() => _ResearchState();
}

class _ResearchState extends State<Research> {
  connectToAPI(String id, String token) async {
    var apiURL =
        "http://api.sinta.ristekdikti.go.id/author/detail/research/" + id;
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
          title: Text('Research'),
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
                    var article =
                        snapshot.data['author']['researchs']['article'];
                    return ListView.builder(
                        itemCount: article.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                title: Text(
                                  article[index]['judul'],
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Text("Skema : " +
                                        article[index]['nama_singkat_skema'] +
                                        " | " +
                                        "Source : " +
                                        article[index]['nama_singkat_skema']),
                                    Text("Thn.usulan : " +
                                        article[index]['thn_usulan_kegiatan'] +
                                        " | " +
                                        "Thn.pelaksanaan : " +
                                        article[index]
                                            ['thn_pelakasanaan_kegiatan'] +
                                        " | " +
                                        "Dana Disetujui : " +
                                        article[index]['dana_disetujui']),
                                    Text(article[index]['bidang_fokus'])
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
