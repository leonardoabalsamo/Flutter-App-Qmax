class Inversor {
  late int id;
  late String modelo;
  late num tensionNominal;
  late int potencia;
  var inv = <Inversor>[];

  Inversor(
      {required this.id,
      required this.modelo,
      required this.tensionNominal,
      required this.potencia});

  String get modeloInversor {
    return modelo;
  }

  num get tensionNominalInversor {
    return tensionNominal;
  }

  int get potenciaInversor {
    return potencia;
  }

  set modeloInversor(String value) {
    modelo = value;
  }

  set tensionNominalInversor(num value) {
    tensionNominal = value;
  }

  set potenciaInversor(int value) {
    potencia = value;
  }

  Inversor buscaInversor(String? modelo) {
    creaInversores();
    return inv.firstWhere((Inversor m) => m.modeloInversor == modelo);
  }

  void creaInversores() {
    /**************Inversores 12V*************/
    inv.add(Inversor(
        id: 1, modelo: 'QM-1212-SPD', tensionNominal: 12, potencia: 1200));
    inv.add(Inversor(
        id: 2, modelo: 'QM-2312-SPD', tensionNominal: 12, potencia: 2300));
    /**************Inversores 24v*************/
    inv.add(Inversor(
        id: 3, modelo: 'QM-1224-SPD', tensionNominal: 24, potencia: 1200));
    inv.add(Inversor(
        id: 4, modelo: 'QM-2324-SPD', tensionNominal: 24, potencia: 2300));
    inv.add(Inversor(
        id: 5, modelo: 'QM-3524-SPD', tensionNominal: 24, potencia: 3500));
    /**************Inversores 48V*************/
    inv.add(Inversor(
        id: 6, modelo: 'QM-1248-SPD', tensionNominal: 48, potencia: 1200));
    inv.add(Inversor(
        id: 7, modelo: 'QM-2348-SPD', tensionNominal: 48, potencia: 2300));
    inv.add(Inversor(
        id: 8, modelo: 'QM-4548-SPD', tensionNominal: 48, potencia: 4500));
  }
}
