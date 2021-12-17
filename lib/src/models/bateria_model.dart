class Bateria {
  String tipo;
  String modelo;
  double fondo;
  double flote;
  num capacidad;
  num tensionNominal;

  Bateria(this.tipo, this.modelo, this.fondo, this.flote, this.capacidad,
      this.tensionNominal);

  num get tensionNominalBateria {
    return tensionNominal;
  }

  set tensionNominalBateria(num value) {
    tensionNominal = value;
  }

  num get capacidadBateria {
    return capacidad;
  }

  set capacidadBateria(num value) {
    capacidad = value;
  }

  String get modeloBateria {
    return modelo;
  }

  set modeloBateria(String value) {
    modelo = value;
  }
}
