class Seleccion {
  int _cantidad;
  String _tipoInstalacion;
  String _red;
  String _tipoSolucion;

  Seleccion(
      this._cantidad, this._tipoInstalacion, this._red, this._tipoSolucion);

  int get getCantidad {
    return _cantidad;
  }

  String get tipoInstalacion {
    return _tipoInstalacion;
  }

  String get red {
    return _red;
  }

  String get tipoSolucion {
    return _tipoSolucion;
  }

  set setCantidad(int cant) {
    _cantidad = cant;
  }

  set setTipoInstalacion(String tipo) {
    _tipoInstalacion = tipo;
  }

  set setRed(String red) {
    _red = red;
  }

  set setTipoSolucion(String tipo) {
    _tipoSolucion = tipo;
  }
}
