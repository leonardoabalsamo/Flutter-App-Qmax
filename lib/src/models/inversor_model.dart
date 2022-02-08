class Inversor {
  String modelo;
  num tensionNominal;
  num potencia;

  Inversor(this.modelo, this.tensionNominal, this.potencia);

  String get modeloInversor {
    return modelo;
  }

  num get tensionNominalInversor {
    return tensionNominal;
  }

  num get potenciaInversor {
    return potencia;
  }

  set modeloInversor(String value) {
    modelo = value;
  }

  set tensionNominalInversor(num value) {
    tensionNominal = value;
  }

  set potenciaInversor(num value) {
    potencia = value;
  }

}
