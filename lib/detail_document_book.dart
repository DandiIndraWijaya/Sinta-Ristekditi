import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Books extends StatefulWidget {
  final String data;
  final String data2;

  Books({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  connectToAPI(String id,String token) async {
    var apiURL =
        "http://api.sinta.ristekdikti.go.id/author/detail/book/" + id;
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
          title: Text('Books'),
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
                    var book = snapshot.data['author']['books']['book'];
                    return ListView.builder(
                        itemCount: book.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                leading: Text('-', style: TextStyle(fontSize: 25),),
                                title: Text(
                                  book[index]['title'], style: TextStyle(color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Text("ISBN : " + book[index]['ISBN']),
                                    Text("Authors : " + book[index]['author_name']),
                                    Text("Publisher : " + book[index]['penerbit']),
                                    Text(book[index]['tempat'] = " | " + book[index]['year']),
                                  ],
                                )
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
