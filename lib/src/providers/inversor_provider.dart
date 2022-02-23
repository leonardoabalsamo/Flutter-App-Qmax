import 'package:flutter/material.dart';
import '../models/inversor_model.dart';

class InversorProvider extends ChangeNotifier {
  /// Instancia del Inversor
  late Inversor _inversorSeleccionado;

  Inversor get getInversor {
    notifyListeners();
    return _inversorSeleccionado;
  }

  set setInversor(Inversor inv) {
    _inversorSeleccionado = inv;
    notifyListeners();
  }
}
