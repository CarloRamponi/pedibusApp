import 'package:flutter/material.dart';
import 'package:pedibus_app/linee_page.dart';

MyApp app;

void main() {
  app = new MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pedibus Cles',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new LineePage(),
    );
  }
}