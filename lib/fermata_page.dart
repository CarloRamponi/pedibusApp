import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/query.dart';

class FermataPage extends StatefulWidget {

  final int id;
  final String name;

  FermataPage({Key key, int id, String name}) : id = id, name = name, super(key: key);

  @override
  _FermataPageState createState() => new _FermataPageState(id, name);

}

class _FermataPageState extends State<FermataPage> {

  int id;
  String name;

  _FermataPageState(int id, String name): id = id, name = name;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [fermata] and id = '" + id.toString() + "'"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            String address;
            double lat, lng;

            address = snapshot.data['searchHits'][0]['data']['ita-IT']['geo']['address'];
            lat = snapshot.data['searchHits'][0]['data']['ita-IT']['geo']['latitude'];
            lng = snapshot.data['searchHits'][0]['data']['ita-IT']['geo']['longitude'];

            return new Container(
                margin: const EdgeInsets.all(15.0),
                child: new ListView(
                  children: <Widget>[
                    new Text("Lat: " + lat.toString() + "\tLng: " + lng.toString()),
                    new Text(
                      address,
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
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
