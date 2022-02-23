class Inversor {
  int id;
  String modelo;
  int tensionNominal;
  int potencia;

  Inversor(this.id, this.modelo, this.tensionNominal, this.potencia);

  String get modeloInversor {
    return modelo;
  }

  int get tensionNominalInversor {
    return tensionNominal;
  }

  int get potenciaInversor {
    return potencia;
  }

  set modeloInversor(String value) {
    modelo = value;
  }

  set tensionNominalInversor(int value) {
    tensionNominal = value;
  }

  set potenciaInversor(int value) {
    potencia = value;
  }
}
