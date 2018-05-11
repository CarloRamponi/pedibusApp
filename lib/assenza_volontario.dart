class AssenzaVolontario {

  DateTime giorno;
  String linea;

  AssenzaVolontario({DateTime giorno, String linea}): giorno = giorno, linea = linea;

}

class AssenzeVolontario {

  List<AssenzaVolontario> assenze;

  AssenzeVolontario({Map<String, dynamic> data}){

    assenze = new List();
    for(int i = 0; i < data['totalCount']; i++) {
      var tmpAss = data['searchHits'][i]['data']['ita-IT'];

      assenze.add(
          new AssenzaVolontario(
              linea: tmpAss['linea'][0]['name']['ita-IT'],
              giorno: DateTime.parse(tmpAss['data']).toLocal()
          )
      );
    }

  }

}