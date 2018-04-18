import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/mydrawer.dart';

class LineePage extends StatefulWidget {
  LineePage({Key key}) : super(key: key);
  final String title = "Linee";
  @override
  _LineePageState createState() => new _LineePageState();
}

class _LineePageState extends State<LineePage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Riga 1',
            ),
            new Text(
              'Riga 2',
            ),
          ],
        ),
      ),
      drawer: new MyDrawer(1, context),
    );
  }
}
