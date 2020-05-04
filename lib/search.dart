import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'model.dart';
import 'login.dart';
import 'author_detail.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  Login login = null;

  Authors hasil = null;

  List<Widget> output = [];
  Widget loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Author'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: "Cari..."),
                  onChanged: (text) {},
                ),
                RaisedButton(
                    child: Text('Search'),
                    onPressed: () {
                      output.clear();
                      setState(() {
                        loading = Loading(
                            indicator: BallPulseIndicator(),
                            size: 100.0,
                            color: Colors.lightBlue[100]);
                      });

                      String search = controller.text;
                      Login.connectToAPI().then((value) {
                        login = value;
                        String token = login.token;

                        SearchAuthor.connectToAPI(token, search)
                            .then((authors) {
                          for (int i = 0; i < authors.length; i++) {
                            setState(() {
                              loading = null;
                              output.add(Card(
                                child: ListTile(
                                  title: Text(authors[i].fullname.toString()),

                                  subtitle: Text(authors[i].name.toString()),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AuthorDetail(
                                          data:
                                              'Hello there form the first page!',
                                          data2: token),
                                    ));
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       new MaterialPageRoute(
                                  //           builder: (context) => '/'));
                                  // },
                                ),
                              ));
                            });
                          }
                        });
                      });
                    }),
                Container(child: loading),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: output,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
