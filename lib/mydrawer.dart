import 'package:flutter/material.dart';
import 'package:pedibus_app/home_page.dart';
import 'package:pedibus_app/linee_page.dart';

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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              if(pageIndex != 0)
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => new MyHomePage())
                );
            },
          ),
          new ListTile(
            leading: const Icon(Icons.directions),
            title: const Text('Linee'),
            onTap: () {
              Navigator.of(context).pop();
              if(pageIndex != 1)
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => new LineePage())
                );
            },
          ),
          new AboutListTile(
            applicationName: 'Pedibus App',
            applicationVersion: '0.1',
            applicationLegalese: 'App created by Carlo Ramponi\nIf you steal my code i will kill you.',
            //TODO icona dell'app
          )
        ],
      )
  );
}