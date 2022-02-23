import 'package:flutter/material.dart';

import '../models/bateria_model.dart';

class BateriaProvider extends ChangeNotifier {
  late Bateria _bateriaSeleccionada;

  Bateria get getBateria {
    return _bateriaSeleccionada;
  }

  set setBateria(Bateria bat) {
    _bateriaSeleccionada = bat;
  }
}
