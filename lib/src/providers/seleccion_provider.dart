import 'package:flutter/material.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';

class SeleccionProvider extends ChangeNotifier {
  String inversor = 'SELECCIONE EL INVERSOR';
  String bateria = 'SELECCIONE LA BATERIA';
  String cantBat = 'SELECCIONE LA CANTIDAD';
  String tipoInstalacion = 'TIPO DE INSTALACION';
  String red = 'RED ELECTRICA';
  String tipoSolucion = 'TIPO DE SOLUCION';

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

// Metodo validacion de bancos
  bool validacion() {
    num aux;

    if (inversorSeleccionado.tensionNominalInversor <
        bateriaSeleccionada.tensionNominalBateria) return false;

    aux = inversorSeleccionado.tensionNominalInversor /
        bateriaSeleccionada.tensionNominalBateria;

    //print('Valor de aux: ' + aux.toString());

    if (num.parse(cantBat) == aux ||
        num.parse(cantBat) == (aux * 2) ||
        num.parse(cantBat) == (aux * 3) ||
        num.parse(cantBat) == (aux * 4)) {
      //print('Cantidad de baterias: ' + cantBat);
      return true;
    } else {
      return false;
    }
  }
}
