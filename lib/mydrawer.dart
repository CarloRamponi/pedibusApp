import 'package:flutter/material.dart';
import 'package:pedibus_app/genitori_page.dart';
import 'package:pedibus_app/linee_page.dart';
import 'package:pedibus_app/volontari_page.dart';

class MyDrawer extends Drawer {
  MyDrawer(int pageIndex, BuildContext context) : super(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Carlo Ramponi'),
            accountEmail: const Text('carloramponi1999@gmail.com'),
            currentAccountPicture: new CircleAvatar(
              child: new Text('CR'),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.directions),
            title: const Text('Linee'),
            selected: pageIndex == 0,
            onTap: () {
              Navigator.of(context).pop();
              if(pageIndex != 0)
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => new LineePage())
                );
            },
          ),
          new ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Volontari'),
            selected: pageIndex == 1,
            onTap: () {
              Navigator.of(context).pop();
              if(pageIndex != 1)
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => new VolontariPage())
                );
            },
          ),
          new ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Genitori'),
            selected: pageIndex == 2,
            onTap: () {
              Navigator.of(context).pop();
              if(pageIndex != 2)
              Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new GenitoriPage())
              );
            },
          ),
          new AboutListTile(
            applicationName: 'Pedibus App',
            applicationVersion: '0.1',
            applicationLegalese: 'App created by Carlo Ramponi & Nicola Salsotto & Lorenzo Gebelin\nIf you steal our code we will kill you.',
            applicationIcon: new Image(image: new AssetImage("resources/logo.png"), height: 80.0, width: 80.0),
            icon: new ImageIcon(new AssetImage("resources/logo.png")),
          )
        ],
      )
  );
}