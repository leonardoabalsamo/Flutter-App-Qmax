import 'package:flutter/material.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';

class SeleccionProvider extends ChangeNotifier {
  //var seleccionSeleccionada = Seleccion(0, "", "", "");

  var bateriaSeleccionada = Bateria(
      id: 0,
      tipo: "",
      capacidad: 0,
      modelo: "",
      tensionNominal: 0,
      flote: 0,
      fondo: 0);

  var inversorSeleccionado =
      Inversor(id: 0, modelo: "", tensionNominal: 0, potencia: 0);

  // late int cantidadSeleccionada;
  // late String tipoSeleccionado;
  // late String redSeleccionada;
  // late String solucionSeleccionada;

  // Seleccion get getSeleccion {
  //   return seleccionSeleccionada;
  // }

  // set setSeleccion(Seleccion S) {
  //   seleccionSeleccionada = S;
  //   notifyListeners();
  // }

//Funciones de los modelos

  Bateria get getBateria {
    return bateriaSeleccionada;
  }

  set setBateria(Bateria bat) {
    bateriaSeleccionada = bat;
    notifyListeners();
  }

  Inversor getInversor() {
    return inversorSeleccionado;
  }

  set setInversor(Inversor inv) {
    inversorSeleccionado = inv;
    notifyListeners();
  }

// Metodos para las pages

  bool validacion() {
    num aux;

    if (inversorSeleccionado.tensionNominalInversor <
        bateriaSeleccionada.tensionNominalBateria) return false;

    aux = inversorSeleccionado.tensionNominalInversor /
        bateriaSeleccionada.tensionNominalBateria;

    if (Seleccion.cantidad == aux ||
        Seleccion.cantidad == (aux * 2) ||
        Seleccion.cantidad == (aux * 3) ||
        Seleccion.cantidad == (aux * 4)) {
      return true;
    } else {
      return false;
    }
  }

  void setState(Null Function() param0) {}
}
