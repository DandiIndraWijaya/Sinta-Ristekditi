import 'package:flutter/material.dart';

class AuthorOverview extends StatefulWidget {
  final String data;
  final String data2;

  AuthorOverview({
    Key key,
    @required this.data,
    @required this.data2,
  }) : super(key: key);
  @override
  _AuthorOverviewState createState() => _AuthorOverviewState();
}

class _AuthorOverviewState extends State<AuthorOverview> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Author OverView')),
        body: Text(widget.data2),
      ),
    );
  }
}
