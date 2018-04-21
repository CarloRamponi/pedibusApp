import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/linea_page.dart';
import 'package:pedibus_app/mydrawer.dart';
import 'package:pedibus_app/query.dart';

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
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [linea] sort [ name => asc ]"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Widget> list = new List(snapshot.data['totalCount']);

            for(int i = 0; i < snapshot.data['totalCount']; i++) {
              list[i] = new ListTile(
                leading: new Icon(Icons.map),
                title: new Text(snapshot.data['searchHits'][i]['data']['ita-IT']['nome']),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => new LineaPage(
                        title: snapshot.data['searchHits'][i]['data']['ita-IT']['nome'],
                        data: snapshot.data['searchHits'][i]['data'],
                      ))
                  );
                },
              );
            }

            return new ListView(
              children: list,
            );

          } else if (snapshot.hasError) {

            return new Center(
              child: new Text("${snapshot.error}")
            );

          }

          return new Center (
              child: new CircularProgressIndicator(),
          );
        },
      ),
      drawer: new MyDrawer(1, context),
    );
  }
}
