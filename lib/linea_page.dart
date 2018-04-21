import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedibus_app/query.dart';

class LineaPage extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  LineaPage({Key key, String title, Map<String, dynamic> data}) : title = title, data = data, super(key: key);

  @override
  _LineaPageState createState() => new _LineaPageState(data);

}

class MyExpansionPanelItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  MyExpansionPanelItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class _LineaPageState extends State<LineaPage> {

  List<MyExpansionPanelItem> _items;

  _LineaPageState(Map<String, dynamic> data) {

    List<Widget> _fermate = new List<Widget>(data['ita-IT']['fermate'].length);

    for(int i = 0; i < data['ita-IT']['fermate'].length; i++){
      _fermate[i] = new ListTile(
          leading: new Icon(Icons.place),
          title: new Text(data['ita-IT']['fermate'][i]['name']['ita-IT'].split("(")[0])
      );
    }

    _items = <MyExpansionPanelItem>[
      new MyExpansionPanelItem(
          false,
          'Fermate',
          new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new Column(
                  children: _fermate,
              ),
          ),
          new Icon(Icons.map)
      ),
      new MyExpansionPanelItem(
          false,
          'Assenze volontari',
          new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FutureBuilder<Map<String, dynamic>>(
                future: Query.query("classes [assenza_volontario] and linea.codice = '" + data['ita-IT']['codice'] + "' and data range [today, *]"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    List<Widget> list = new List(snapshot.data['totalCount']);

                    for(int i = 0; i < snapshot.data['totalCount']; i++) {
                      DateTime giorno = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['data']).toLocal();
                      String volontario = snapshot.data['searchHits'][i]['data']['ita-IT']['volontario'][0]['name']['ita-IT'];
                      list[i] = new ListTile(
                        title: new Text(giorno.day.toString() + "/" + giorno.month.toString() + "/" + giorno.year.toString() + " → " + volontario ),
                      );
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
          new Icon(Icons.event_busy)
      ),
      new MyExpansionPanelItem(
          false,
          'Assenze bambini',
          new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FutureBuilder<Map<String, dynamic>>(
                future: Query.query("classes [assenza_bambino] and linea.codice = '" + data['ita-IT']['codice'] + "' and data range [today, *]"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    List<Widget> list = new List(snapshot.data['totalCount']);

                    for(int i = 0; i < snapshot.data['totalCount']; i++) {
                      DateTime giorno = DateTime.parse(snapshot.data['searchHits'][i]['data']['ita-IT']['data']).toLocal();
                      String bambino = snapshot.data['searchHits'][i]['data']['ita-IT']['bambino'][0]['name']['ita-IT'];
                      list[i] = new ListTile(
                        title: new Text(giorno.day.toString() + "/" + giorno.month.toString() + "/" + giorno.year.toString() + " → " + bambino ),
                      );
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
          new Icon(Icons.event_busy)
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(
        children: <Widget>[
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !_items[index].isExpanded;
              });
            },
            children: _items.map((MyExpansionPanelItem item) {
              return new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                      leading: item.iconpic,
                      title: new Text(item.header)
                  );
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
