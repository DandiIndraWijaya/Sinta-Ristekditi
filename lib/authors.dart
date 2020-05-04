import 'package:flutter/material.dart';
import 'package:json_list/list_authors.dart';
import 'package:json_list/search.dart';

import 'login.dart';

class Authors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Container(
              child: Text('Authors'),
            ),
            onTap: () {
              Login.connectToAPI().then((value) {
                        Login login = value;
                        String token = login.token;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ListAuthors(
                              data: token,)
                        ));
                      });
            },
          ),
          GestureDetector(
            child: Container(
              child: Text('Search Author'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Search(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
