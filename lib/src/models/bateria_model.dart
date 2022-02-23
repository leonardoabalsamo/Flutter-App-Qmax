class Bateria {
  int id;
  String tipo;
  String modelo;
  double fondo;
  double flote;
  int capacidad;
  int tensionNominal;

  Bateria(
      {required this.id,
      required this.tipo,
      required this.modelo,
      required this.fondo,
      required this.flote,
      required this.capacidad,
      required this.tensionNominal});

  int get tensionNominalBateria {
    return tensionNominal;
  }

  set tensionNominalBateria(int value) {
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
/*
  // Implement toString to make it easier to see information about
  @override
  String toString() {
    return 'bateria {id: $id, tipo: $tipo, modelo: $modelo, fondo: $fondo, flote: $flote , capacidad: $capacidad , tensionNominal: $tensionNominal}';
  }
}

Future<void> insertBat(Bateria bat) async {
  // Obtiene una referencia de la base de datos
  final Database db = await database;

  // Inserta el Dog en la tabla correcta. También puede especificar el
  // `conflictAlgorithm` para usar en caso de que el mismo Dog se inserte dos veces.
  // En este caso, reemplaza cualquier dato anterior.
  await db.insert(
    'baterias',
    bat.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );*/
}
