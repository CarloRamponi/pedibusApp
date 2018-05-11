import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/calendar_tile.dart';
import 'package:pedibus_app/assenza_volontario.dart';
import 'package:pedibus_app/disponibilita_volontario.dart';
import 'package:pedibus_app/query.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class CalendarioVolontarioPage extends StatefulWidget {

  final int id;
  final String name;

  CalendarioVolontarioPage({Key key, int id, String name}) : id = id, name = name, super(key: key);

  @override
  _CalendarioVolontarioPageState createState() => new _CalendarioVolontarioPageState(id, name);

}

class _CalendarioVolontarioPageState extends State<CalendarioVolontarioPage> {

  int id;
  String name;
  DisponibilitasVolontario disponibilita;
  AssenzeVolontario assenze;

  _CalendarioVolontarioPageState(int id, String name): id = id, name = name;
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body: new FutureBuilder<Map<String, dynamic>>(
        future: Query.query("classes [disponibilita] and volontario.id = '" + id.toString() + "'"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            disponibilita = new DisponibilitasVolontario(data: snapshot.data);

            return new FutureBuilder<Map<String, dynamic>>(
              future: Query.query("classes [assenza_volontario] and volontario.id = '" + id.toString() + "' sort [ data => desc ]"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  assenze = new AssenzeVolontario(data: snapshot.data);

                  return new Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: new Calendar(
                      showTodayAction: false,
                      showCalendarPickerIcon: false,
                      isExpandable: true,
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
