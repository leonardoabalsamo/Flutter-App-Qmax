import 'package:flutter/material.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';

class SeleccionProvider extends ChangeNotifier {
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

  Map<String, dynamic> data = {
    '1': 2, // Permiso de escritura ||||||
    '2':
        0, // Modo de funcionamiento |||| 0=Inv/Carg - 1=Solo Cargador - 2=Autoconsumo
    '167': 0, // Perfil de entrada ||||||| 0=Estricta - 1=Tolerante
    '10': 0, // capacidad banco  ||||||||| Min: 50 - Max: 20000
    '13':
        'PerfilBateria', // Perfil bat|| PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
    '180': 0, // V bat paso a red ||||||||
    '182': 0, // V bat retorno de red |||||
  };

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
