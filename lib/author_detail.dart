import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_list/author_overview.dart';
import 'package:json_list/detail_bimbingan.dart';
import 'package:json_list/detail_document_book.dart';
import 'package:json_list/detail_document_google_scholar.dart';
import 'package:json_list/detail_document_ipr.dart';
import 'package:json_list/detail_research.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'login.dart';
import 'detail_document_scopus.dart';

class Author {
  // String name;

  // Author({this.name});

  // factory Author.createAuthor(Map<String, dynamic> object) {
  //   return Author(
  //     name: object["author"]['name'],
  //   );
  // }

}

class AuthorDetail extends StatefulWidget {
  final String data;
  final String data2;

  AuthorDetail({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);

  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  connectToAPI(String token) async {
    var apiURL = "http://api.sinta.ristekdikti.go.id/author/detail/59706";
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

  // void initState() {
  //   Login.connectToAPI().then((value) {
  //     login = value;
  //     String token = login.token;

  //     Author.connectToAPI(token).then((hasil) {
  //       setState(() {
  //         String name = hasil.name.toString();
  //       });
  //     });
  //   });
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Author Detail"),
      ),
      body: FutureBuilder(
        future: connectToAPI(widget.data2),
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
              return ListView(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(snapshot.data['author']['name']),
                        )),
                        Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              snapshot.data['author']['afiliation']['name']),
                        )),
                        Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(snapshot.data['author']['id'].toString()),
                        )),
                        Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(snapshot.data['author']['country']),
                        )),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Text('Gambar')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(snapshot.data['author']['sinta_score']
                                  .toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(snapshot.data['author']
                                      ['sinta_score_v2']
                                  .toString()),
                            )
                          ],
                        ),
                        Divider(color: Colors.blueGrey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(snapshot.data['author']
                                      ['sinta_score_3']
                                  .toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(snapshot.data['author']
                                      ['sinta_score_v2_3y']
                                  .toString()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                      child: Container(
                    child: Column(
                      children: <Widget>[
                        Text('Research Output'),
                        Text(snapshot.data['author']['scopus_article']
                            .toString())
                      ],
                    ),
                  )),
                  Card(
                    child: Image.asset('images/Sinta.png'),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'gambar',
                                style: TextStyle(fontSize: 7),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Scopus')),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Google')),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Documents',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['scopus_article']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['google_article']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Citations',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['scopus_citation']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['google_citations']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('H-Index',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['scopus_hindex']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['google_hindex']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('i10-Index',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['scopus_i10']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['google_i10']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('G-Index',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['scopus_gindex']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data['author']['google_gindex']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.lightBlue)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Card(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(7.0),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: <Widget>[
                  //               Text(
                  //                 'gambar',
                  //                 style: TextStyle(fontSize: 7),
                  //               ),
                  //               Text('Documents',
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.black)),
                  //               Text('Citations',
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.black)),
                  //               Text('H-Index',
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.black)),
                  //               Text('i10-Index',
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.black)),
                  //               Text('G-Index',
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.black)),
                  //             ],
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: <Widget>[
                  //               Text('Scopus'),
                  //               Text(
                  //                   snapshot.data['author']['scopus_article']
                  //                       .toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.lightBlue)),
                  //               Text(
                  //                   snapshot.data['author']['scopus_citation']
                  //                       .toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.lightBlue)),
                  //               Text(
                  //                   snapshot.data['author']['scopus_hindex']
                  //                       .toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.lightBlue)),
                  //               Text(
                  //                   snapshot.data['author']['scopus_i10']
                  //                       .toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.lightBlue)),
                  //               Text(
                  //                   snapshot.data['author']['scopus_gindex']
                  //                       .toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.lightBlue)),
                  //             ],
                  //           ),
                  //         ),
                  //         Column(
                  //           children: <Widget>[
                  //             Divider(
                  //               color: Colors.grey,
                  //             )
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Text('Google'),
                  //             Text(snapshot.data['author']['google_article']
                  //                 .toString()),
                  //             Text(snapshot.data['author']['google_citations']
                  //                 .toString()),
                  //             Text(snapshot.data['author']['google_hindex']
                  //                 .toString()),
                  //             Text(snapshot.data['author']['google_i10']
                  //                 .toString()),
                  //             Text(snapshot.data['author']['google_gindex']
                  //                 .toString()),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Card(
                      child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Quaritle Scopus')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(snapshot.data['author']['scopus_quartile']
                                  ['1']
                              .toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(snapshot.data['author']['scopus_quartile']
                                  ['2']
                              .toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(snapshot.data['author']['scopus_quartile']
                                  ['3']
                              .toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(snapshot.data['author']['scopus_quartile']
                                  ['undefined']
                              .toString()),
                        ),
                      ],
                    ),
                  ])),
                  RaisedButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AuthorOverview(
                          data: 'Hello there form the first page!',
                          data2: snapshot.data['author']['id'].toString()),
                    ));
                  }),
                  RaisedButton(
                      child: Text('Scopus Document'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DocumentScopus(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                  RaisedButton(
                      child: Text('Google Scholar Document'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DocumentGoogle(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                  RaisedButton(
                      child: Text('Books'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Books(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                  RaisedButton(
                      child: Text('IPR'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IPR(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                  RaisedButton(
                      child: Text('Rama Documents'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Rama(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                  RaisedButton(
                      child: Text('Research'),
                      onPressed: () {
                        Login.connectToAPI().then((value) {
                          Login login = value;
                          String token = login.token;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Research(
                                data: snapshot.data['author']['id'].toString(),
                                data2: token),
                          ));
                        });
                      }),
                ],
              );
          }
          // if (snapshot.hasData) {
          //   print(snapshot.data);
          //   return Container(child: Center(child: Text('j')));
          // } else {
          //   return Container(
          //     child: Center(child: Text('error')),
          //   );
          // }
        },
      ),
      // child: Center(child: Text(widget.data2)),
    );
  }
}
