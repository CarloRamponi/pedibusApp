import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/genitore_page.dart';
import 'package:pedibus_app/mydrawer.dart';
import 'package:pedibus_app/query.dart';

class GenitoriPage extends StatefulWidget {

  GenitoriPage({Key key}) : super(key: key);
  final String title = "Volontari";

  @override
  _GenitoriPageState createState() => new _GenitoriPageState();

}

class _GenitoriPageState extends State<GenitoriPage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [adulto] and ruolo contains ['genitore']"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Widget> list = new List(snapshot.data['totalCount']);

            for(int i = 0; i < snapshot.data['totalCount']; i++) {
              list[i] = new ListTile(
                leading: new Icon(Icons.person),
                title: new Text(snapshot.data['searchHits'][i]['data']['ita-IT']['nome'] + " " + snapshot.data['searchHits'][i]['data']['ita-IT']['cognome']),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => new GenitorePage(
                        name: snapshot.data['searchHits'][i]['data']['ita-IT']['nome'] + " " + snapshot.data['searchHits'][i]['data']['ita-IT']['cognome'],
                        id: snapshot.data['searchHits'][i]['metadata']['id'],
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
      drawer: new MyDrawer(2, context),
    );
  }
}
