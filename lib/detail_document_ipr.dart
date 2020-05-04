import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class IPR extends StatefulWidget {
  final String data;
  final String data2;

  IPR({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _IPRState createState() => _IPRState();
}

class _IPRState extends State<IPR> {
  connectToAPI(String id, String token) async {
    var apiURL = "http://api.sinta.ristekdikti.go.id/author/detail/ipr/" + id;
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
          title: Text('IPR'),
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
                    var ipr = snapshot.data['author']['hki']['hki'];
                    return ListView.builder(
                        itemCount: ipr.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                leading: Text(
                                  '-',
                                  style: TextStyle(fontSize: 25),
                                ),
                                title: Text(
                                  ipr[index]['title'],
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Text("ID : " + ipr[index]['id']),
                                    Text(
                                        "Kategori : " + ipr[index]['kategori']),
                                    Text("Petent Hoder : " +
                                        ipr[index]['pemegang_paten']),
                                    Text("Inventor : "),
                                    Text(ipr[index]['inventor'])
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
