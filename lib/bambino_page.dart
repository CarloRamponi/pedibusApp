import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/linea_page.dart';
import 'package:pedibus_app/query.dart';

class BambinoPage extends StatefulWidget {

  final int id;
  final String name;

  BambinoPage({Key key, int id, String name}) : id = id, name = name, super(key: key);

  @override
  _BambinoPageState createState() => new _BambinoPageState(id, name);

}

class _BambinoPageState extends State<BambinoPage> {

  int id;
  String name;

  _BambinoPageState(int id, String name): id = id, name = name;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [adesione] and bambino.id = '" + id.toString() + "'"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Widget> elementiLista = new List();

            for(int i = 0; i < snapshot.data['totalCount']; i++){
              for(int j = 0; j < snapshot.data['searchHits'][i]['data']['ita-IT']['linea'].length; j++) {
                elementiLista.add(
                  new ListTile(
                    leading: new Icon(Icons.map),
                    title: new Text(snapshot.data['searchHits'][i]['data']['ita-IT']['linea'][j]['name']['ita-IT']),
                  ),
                );
              }

              DateTime dal = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['dal']).toLocal();
              DateTime al = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['al']).toLocal();

              elementiLista.add(
                new Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: new ListTile(
                    leading: new Icon(Icons.calendar_today),
                    title: new Text(dal.day.toString() + "/" + dal.month.toString() + "/" + dal.year.toString() + "  -  " + al.day.toString() + "/" + al.month.toString() + "/" + al.year.toString()),
                  ),
                )
              );

              elementiLista.add(
                new Divider()
              );

            }

            return new ListView(
              children: elementiLista,
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
    );
  }
}
