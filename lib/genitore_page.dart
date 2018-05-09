import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/query.dart';

class GenitorePage extends StatefulWidget {

  final int id;
  final String name;

  GenitorePage({Key key, int id, String name}) : id = id, name = name, super(key: key);

  @override
  _GenitorePageState createState() => new _GenitorePageState(id, name);

}

class _GenitorePageState extends State<GenitorePage> {

  int id;
  String name;

  _GenitorePageState(int id, String name): id = id, name = name;

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
            //String iniziali = snapshot.data['searchHits'][0]['data']['ita-IT']['nome'][0] + snapshot.data['searchHits'][0]['data']['ita-IT']['cognome'][0];

            List<Widget> elementiLista = <Widget>[
              /*new CircleAvatar(
                  child: new Text(iniziali, style: new TextStyle(fontSize: 50.0),),
                  radius: 80.0,
                ),*/
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
              new Divider(),
            ];

            for(int i = 0; i < snapshot.data['searchHits'][0]['data']['ita-IT']['figli'].length; i++){
              elementiLista.add(new ListTile(
                leading: new Icon(Icons.face),
                title: new Text(snapshot.data['searchHits'][0]['data']['ita-IT']['figli'][i]['name']['ita-IT']),
              ));
            }

            return new ListView(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
