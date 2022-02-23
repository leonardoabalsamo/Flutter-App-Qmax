import 'package:flutter/material.dart';

import '../models/seleccion_model.dart';

class SeleccionProvider extends ChangeNotifier {
  late Seleccion _seleccion;

  SeleccionProvider(this._seleccion);

  Seleccion get getSeleccion {
    return _seleccion;
  }

  set setSeleccion(Seleccion S) {
    _seleccion = S;
  }
}
