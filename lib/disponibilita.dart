class Disponibilita {

  DateTime dal;
  DateTime al;
  String linea;
  List<bool> giorni;

  Disponibilita({DateTime dal, DateTime al, String linea, List<bool> giorni}) : dal = dal, al = al, linea = linea, giorni = giorni;

  bool isDisponibile(DateTime giorno){
    return giorni[giorno.weekday-1] && giorno.isAfter(dal) && giorno.isBefore(al) /* TODO: && controllo sui giorni di vacanza */;
  }

}