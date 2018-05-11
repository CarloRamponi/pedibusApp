class DisponibilitaVolontario {

  DateTime dal;
  DateTime al;
  String linea;
  List<bool> giorni;

  DisponibilitaVolontario({DateTime dal, DateTime al, String linea, List<bool> giorni}) : dal = dal, al = al, linea = linea, giorni = giorni;

  bool isDisponibile(DateTime giorno){
    return giorni[giorno.weekday-1] && giorno.isAfter(dal) && giorno.isBefore(al) /* TODO: && controllo sui giorni di vacanza */;
  }

}

class DisponibilitasVolontario {

  List<DisponibilitaVolontario> disponibilitas;

  DisponibilitasVolontario({Map<String, dynamic> data}) {
    disponibilitas = new List();

    for (int i = 0; i < data['totalCount']; i++) {
      var tmpDisp = data['searchHits'][i]['data']['ita-IT'];
      List<bool> giorni = new List(5);
      for (int j = 0; j < 5; j++) {
        giorni[j] = false;
      }

      for (int j = 0; j < tmpDisp['giorno'].length; j++) {
        switch (tmpDisp['giorno'][j]['name']['ita-IT']) {
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


      disponibilitas.add(
          new DisponibilitaVolontario(
            giorni: giorni,
            linea: tmpDisp['linea'][0]['name']['ita-IT'],
            dal: DateTime.parse(tmpDisp['dal']).toLocal(),
            al: DateTime.parse(tmpDisp['al']).toLocal(),
          )
      );
    }
  }

}