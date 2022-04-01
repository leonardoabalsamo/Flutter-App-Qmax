class Bateria {
  int id;
  String tipo;
  String modelo;
  double fondo;
  double flote;
  int capacidad;
  num tensionNominal;
  var bat = <Bateria>[];

  Bateria(
      {required this.id,
      required this.tipo,
      required this.modelo,
      required this.fondo,
      required this.flote,
      required this.capacidad,
      required this.tensionNominal});

  num get tensionNominalBateria {
    return tensionNominal;
  }

  set tensionNominalBateria(num value) {
    tensionNominal = value;
  }

  int get capacidadBateria {
    return capacidad;
  }

  set capacidadBateria(int value) {
    capacidad = value;
  }

  String get modeloBateria {
    return modelo;
  }

  set modeloBateria(String value) {
    modelo = value;
  }

  Bateria buscaBateria(String? modelo) {
    creaBaterias();
    return bat.firstWhere((Bateria m) => m.modeloBateria == modelo);
  }

  creaBaterias() {
    bat.add(Bateria(
        id: 1,
        tipo: 'PB-ACIDO',
        modelo: 'TROJAN T105',
        fondo: 7.25,
        flote: 6.8,
        capacidad: 225,
        tensionNominal: 6));
    bat.add(Bateria(
        id: 2,
        tipo: 'PB-ACIDO',
        modelo: 'TROJAN T605',
        fondo: 7.25,
        flote: 6.8,
        capacidad: 210,
        tensionNominal: 6));
    bat.add(Bateria(
        id: 3,
        tipo: 'PB-ACIDO',
        modelo: 'TROJAN 27TMX',
        fondo: 14.82,
        flote: 13.50,
        capacidad: 105,
        tensionNominal: 12));
    bat.add(Bateria(
        id: 4,
        tipo: 'AGM',
        modelo: 'VISION 6FM100X',
        fondo: 7.25,
        flote: 6.8,
        capacidad: 100,
        tensionNominal: 12));
    bat.add(Bateria(
        id: 5,
        tipo: 'AGM',
        modelo: 'VISION 6FM200X',
        fondo: 7.25,
        flote: 6.8,
        capacidad: 200,
        tensionNominal: 12));
    bat.add(Bateria(
        id: 6,
        tipo: 'LITIO',
        modelo: 'PYLONTECH US2000C',
        fondo: 53.5,
        flote: 52.5,
        capacidad: 2400,
        tensionNominal: 48));
    bat.add(Bateria(
        id: 7,
        tipo: 'LITIO',
        modelo: 'PYLONTECH US3000C',
        fondo: 53.5,
        flote: 52.5,
        capacidad: 3552,
        tensionNominal: 48));
    bat.add(Bateria(
        id: 8,
        tipo: 'LITIO',
        modelo: 'PYLONTECH PHANTOM-S',
        fondo: 53.5,
        flote: 52.5,
        capacidad: 2200,
        tensionNominal: 48));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'modelo': modelo,
      'fondo': fondo,
      'flote': flote,
      'capacidad': capacidad,
      'tensionNominal': tensionNominal,
    };
  }
}
