import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/query.dart';

class VolontarioPage extends StatefulWidget {

  final int id;
  final String name;

  VolontarioPage({Key key, int id, String name}) : id = id, name = name, super(key: key);

  @override
  _VolontarioPageState createState() => new _VolontarioPageState(id, name);

}

class _VolontarioPageState extends State<VolontarioPage> {

  int id;
  String name;

  _VolontarioPageState(int id, String name): id = id, name = name;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [adulto] and id = '" + id.toString() + "'"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            String name = snapshot.data['searchHits'][0]['data']['ita-IT']['nome'] + ' ' + snapshot.data['searchHits'][0]['data']['ita-IT']['cognome'];
            String address = snapshot.data['searchHits'][0]['data']['ita-IT']['indirizzo'];
            String telefono = snapshot.data['searchHits'][0]['data']['ita-IT']['telefono'];
            String email = snapshot.data['searchHits'][0]['data']['ita-IT']['email'];
            String iniziali = snapshot.data['searchHits'][0]['data']['ita-IT']['nome'][0] + snapshot.data['searchHits'][0]['data']['ita-IT']['cognome'][0];

            return new ListView(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              children: <Widget>[
                new CircleAvatar(
                  child: new Text(iniziali, style: new TextStyle(fontSize: 50.0),),
                  radius: 80.0,
                ),
                new ListTile(
                  leading: new Icon(Icons.account_circle),
                  title: new Text(name == null ? "Mancante" : name),
                ),
                new ListTile(
                  leading: new Icon(Icons.phone),
                  title: new Text(telefono == null ? "Mancante" : telefono),
                ),
                new ListTile(
                  leading: new Icon(Icons.email),
                  title: new Text(email == null ? "Mancante" : email),
                ),
                new ListTile(
                  leading: new Icon(Icons.map),
                  title: new Text(address == null ? "Mancante" : address),
                ),
              ],
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
