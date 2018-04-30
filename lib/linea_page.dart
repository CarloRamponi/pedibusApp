import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/fermata_page.dart';
import 'package:pedibus_app/query.dart';
import 'package:pedibus_app/volontario_page.dart';

class LineaPage extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  LineaPage({Key key, String title, Map<String, dynamic> data}) : title = title, data = data, super(key: key);

  @override
  _LineaPageState createState() => new _LineaPageState(data);

}

class _LineaPageState extends State<LineaPage> {

  List<bool> _items = new List<bool>(4);
  Map<String, dynamic> data;

  _LineaPageState(Map<String, dynamic> data): data = data {
    for(int i = 0; i < 4; i++)
      _items[i] = false;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _fermate = new List<Widget>(data['data']['ita-IT']['fermate'].length);

    for(int i = 0; i < data['data']['ita-IT']['fermate'].length; i++){
      _fermate[i] = new ListTile(
        leading: new Icon(Icons.place),
        title: new Text(data['data']['ita-IT']['fermate'][i]['name']['ita-IT'].split("(")[0]),
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new FermataPage(
                name: data['data']['ita-IT']['fermate'][i]['name']['ita-IT'].split("(")[0],
                id: data['data']['ita-IT']['fermate'][i]['id'],
              ))
          );
        },
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        children: <Widget>[
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index] = !_items[index];
              });
            },
            children: <ExpansionPanel> [
              new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                      leading: new Icon(Icons.map),
                      title: new Text('Fermate'),
                  );
                },
                isExpanded: _items[0],
                body: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new Column(
                    children: _fermate,
                  ),
                ),
              ),
              new ExpansionPanel(
                isExpanded: _items[1],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                    leading: new Icon(Icons.event_busy),
                    title: new Text('Assenze volontari'),
                  );
                },
                body: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new FutureBuilder<Map<String, dynamic>>(
                    future: Query.query("classes [assenza_volontario] and linea.codice = '" + data['data']['ita-IT']['codice'] + "' and data range [today, *]"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        List<Widget> list;

                        if(snapshot.data['totalCount'] == 0) {
                          list = <Widget>[new Text("Nessuna assenza futura")];
                        } else {
                          list = new List(snapshot.data['totalCount']);
                          for(int i = 0; i < snapshot.data['totalCount']; i++) {
                            DateTime giorno = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['data']).toLocal();
                            String volontario = snapshot.data['searchHits'][i]['data']['ita-IT']['volontario'][0]['name']['ita-IT'];
                            list[i] = new ListTile(
                              title: new Text(giorno.day.toString() + "/" + giorno.month.toString() + "/" + giorno.year.toString() + " → " + volontario ),
                            );
                          }
                        }

                        return new Column(
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
                ),
              ),
              new ExpansionPanel(
                isExpanded: _items[2],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                    leading: new Icon(Icons.event_busy),
                    title: new Text('Assenze bambini'),
                  );
                },
                body: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new FutureBuilder<Map<String, dynamic>>(
                    future: Query.query("classes [assenza_bambino] and linea.codice = '" + data['data']['ita-IT']['codice'] + "' and data range [today, *]"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        List<Widget> list;

                        if(snapshot.data['totalCount'] == 0) {
                          list = <Widget>[new Text("Nessuna assenza futura")];
                        } else {
                          list = new List(snapshot.data['totalCount']);

                          for(int i = 0; i < snapshot.data['totalCount']; i++) {
                            DateTime giorno = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['data']).toLocal();
                            String bambino = snapshot.data['searchHits'][i]['data']['ita-IT']['bambino'][0]['name']['ita-IT'];
                            list[i] = new ListTile(
                              title: new Text(giorno.day.toString() + "/" + giorno.month.toString() + "/" + giorno.year.toString() + " → " + bambino ),
                            );
                          }
                        }

                        return new Column(
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
                ),
              ),
              new ExpansionPanel(
                isExpanded: _items[3],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                    leading: new Icon(Icons.people),
                    title: new Text('Volontari'),
                  );
                },
                body: new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new FutureBuilder<Map<String, dynamic>>(
                    future: Query.query("classes [disponibilita] and linea.id = '" + data['metadata']['id'].toString() + "' and dal range [*, now] and al range [now, *]"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        List<Widget> list;

                        if(snapshot.data['totalCount'] == 0) {
                          list = <Widget>[new Text("Nessuna volontario per questa linea")];
                        } else {
                          list = new List(snapshot.data['totalCount']);

                          for(int i = 0; i < snapshot.data['totalCount']; i++) {
                            String volontario = snapshot.data['searchHits'][i]['data']['ita-IT']['volontario'][0]['name']['ita-IT'];
                            list[i] = new ListTile(
                              leading: new Icon(Icons.face),
                              title: new Text(volontario),
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(builder: (context) =>
                                    new VolontarioPage(
                                      name: snapshot.data['searchHits'][i]['data']['ita-IT']['volontario'][0]['name']['ita-IT'],
                                      id: snapshot.data['searchHits'][i]['data']['ita-IT']['volontario'][0]['id'],
                                    ))
                                );
                              },
                            );
                          }
                        }

                        return new Column(
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
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}
