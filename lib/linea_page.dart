import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineaPage extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  LineaPage({Key key, String title, Map<String, dynamic> data}) : title = title, data = data, super(key: key);

  @override
  _LineaPageState createState() => new _LineaPageState();

}

class MyExpansionPanelItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  MyExpansionPanelItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class _LineaPageState extends State<LineaPage> {

  List<MyExpansionPanelItem> items = <MyExpansionPanelItem>[
    new MyExpansionPanelItem(
      false,
      'Fermate',
      new Padding(
        padding: new EdgeInsets.all(20.0),
        child: new Column(children: <Widget>[
          new Text("Le fermate")
        ])
      ),
      new Icon(Icons.map)
    ),
    new MyExpansionPanelItem(
        false,
        'Assenze volontari',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(children: <Widget>[
              new Text("Le assenze dei volontari")
            ])
        ),
        new Icon(Icons.event_busy)
    ),
    new MyExpansionPanelItem(
        false,
        'Assenze bambini',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(children: <Widget>[
              new Text("Le assenze dei bambini")
            ])
        ),
        new Icon(Icons.event_busy)
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((MyExpansionPanelItem item) {
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
