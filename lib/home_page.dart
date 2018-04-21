import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/mydrawer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title = "Home";
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Container(
          margin: const EdgeInsets.all(15.0),
          child: new Text(
            'Pedibus App!',
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 30.0),
          ),
        ),
      ),
      drawer: new MyDrawer(0, context),
    );
  }

}