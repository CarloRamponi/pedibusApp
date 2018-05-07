import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/calendar_tile.dart';
import 'package:pedibus_app/assenza.dart';
import 'package:pedibus_app/disponibilita.dart';
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
  List<Disponibilita> disponibilita;
  List<Assenza> assenze;

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

            int nDisponibilita = snapshot.data['totalCount'];

            if(nDisponibilita == 0){
              return new Center(child: new Text("Nessuna disponibilità"));
            }

            disponibilita = new List(nDisponibilita);

            for(int i = 0; i < nDisponibilita; i++) {

              var tmpDisp = snapshot.data['searchHits'][i]['data']['ita-IT'];
              List<bool> giorni = new List(5);
              for(int j = 0; j < 5; j++){
                giorni[j] = false;
              }

              for(int j = 0; j < tmpDisp['giorno'].length; j++) {
                switch(tmpDisp['giorno'][j]['name']['ita-IT']){
                  case 'Lunedì':
                    giorni[0] = true;
                    break;
                  case 'Martedì':
                    giorni[1] = true;
                    break;
                  case 'Mercoledì':
                    giorni[2] = true;
                    break;
                  case 'Giovedì':
                    giorni[3] = true;
                    break;
                  case 'Venerdì':
                    giorni[4] = true;
                    break;
                }
              }


              disponibilita[i] = new Disponibilita(
                giorni: giorni,
                linea: tmpDisp['linea'][0]['name']['ita-IT'],
                dal: DateTime.parse(tmpDisp['dal']).toLocal(),
                al: DateTime.parse(tmpDisp['al']).toLocal(),
              );

            }


            return new FutureBuilder<Map<String, dynamic>>(
              future: Query.query("classes [assenza_volontario] and volontario.id = '" + id.toString() + "' sort [ data => desc ]"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  assenze = new List();
                  for(int i = 0; i < snapshot.data['totalCount']; i++) {

                    var tmpAss = snapshot.data['searchHits'][i]['data']['ita-IT'];

                    assenze.add(
                      new Assenza(
                        linea: tmpAss['linea'][0]['name']['ita-IT'],
                        giorno: DateTime.parse(tmpAss['data']).toLocal()
                      )
                    );

                    return new Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: new Calendar(
                        showTodayAction: false,
                        showCalendarPickerIcon: false,
                        isExpandable: true,
                      ),
                    );

                  }

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
