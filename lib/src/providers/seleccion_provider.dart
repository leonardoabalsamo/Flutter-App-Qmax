//import 'dart:ffi';

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
  String tensionBanco = 'SELECCIONE LA TENSION';
  num cantidadBancos = 0;
  num capacidadBanco = 0;

  bool regulador = false;

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

  set setRegulador(bool reg) {
    regulador = reg;
    notifyListeners();
  }

  set setBat(String bat) {
    cantBat = bat;
    notifyListeners();
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

  bool validacionReg() {
    // cantidad de bancos = (tension nominal bateria * cantidad baterias)/tensionBanco

    cantidadBancos =
        (bateriaSeleccionada.tensionNominalBateria * num.parse(cantBat)) /
            num.parse(tensionBanco);

    capacidadBanco = cantidadBancos * bateriaSeleccionada.capacidad;

    print('Cantidad de Bancos: ' + cantidadBancos.toString());
    print('Capacidad del banco: ' + capacidadBanco.toString());

    num aux = (bateriaSeleccionada.tensionNominalBateria) * num.parse(cantBat);

    if (num.parse(tensionBanco) < bateriaSeleccionada.tensionNominalBateria)
      return false;

    //Validación de tensiones
    aux = num.parse(tensionBanco) / bateriaSeleccionada.tensionNominalBateria;

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

  notificar(context) {
    notifyListeners();
  }
}
