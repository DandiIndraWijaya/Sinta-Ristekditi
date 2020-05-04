import 'package:flutter/material.dart';
import 'authors.dart';
import 'search.dart';

void main() => runApp(new Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectdPage = 0;
  final _pageOptions = [  Search(), Authors(), Text("Item 3")];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bottom Nav Bar"),
        ),
        body: _pageOptions[_selectdPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectdPage,
          onTap: (int index) {
            setState(() {
              _selectdPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), title: Text('Authors')),
            BottomNavigationBarItem(
                icon: Icon(Icons.landscape), title: Text('Landscape')),
          ],
        ),
      ),
    );
  }
}
