import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:pedibus_app/query.dart';
import 'package:flutter_map/flutter_map.dart';

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

            double lat, lng;

            lat = snapshot.data['searchHits'][0]['data']['ita-IT']['geo']['latitude'];
            lng = snapshot.data['searchHits'][0]['data']['ita-IT']['geo']['longitude'];

            return new FlutterMap(
              options: new MapOptions(
                center: new LatLng(lat, lng),
                zoom: 16.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoiY2FybG9yIiwiYSI6ImNqZ2Uwdm9oeDAxYXgycW1veHgxZzkwamQifQ.O6a4ZlVGXdFPQU5X08QvUQ',
                    'id': 'mapbox.streets',
                  },
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      point: new LatLng(lat, lng),
                      builder: (ctx) => new Container(
                        child: new Icon(Icons.location_on),
                      ),
                    ),
                  ],
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
