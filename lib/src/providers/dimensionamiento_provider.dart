//import 'dart:ffi';

import 'package:flutter/material.dart';

class DimensionamientoProvider extends ChangeNotifier {
  bool Red = false;
  bool Grupo = false;
  String PanelSeleccionado = '';
  String UbicacionSeleccionada = '';

  double valorFactura = 0;
  double EnergiaDiaria = 0;
  double TensionInversor = 0;
  num CantReg = 0;
  num CantPanel = 0;
  double? Insolacion = 0;
  double PotenciaPaneles = 0;
  double BancoBateria = 0;

  var Ubicaciones = <String>[];
  var Consumos = <String>[];
  var Kit = <Widget>[];

  Map<String, double> _consumosSeleccionados = {};

  Map<String, double> _hsSolaresJson = {
    'Capital Federal': 5.1,
    'Buenos Aires': 5.03,
    'Catamarca': 5.54,
    'Cordoba': 5.05,
    'Corrientes': 5.28,
    'Chaco': 4.78,
    'Chubut': 5.15,
    'Entre Rios': 5.26,
    'Formosa': 5.08,
    'Jujuy': 4.99,
    'La Pampa': 5.21,
    'La Rioja': 4.78,
    'Mendoza': 5.49,
    'Misiones': 4.83,
    'Neuquén': 5.27,
    'Rio Negro': 5.22,
    'Salta': 4.69,
    'San Juan': 6.36,
    'San Luis': 5.71,
    'Santa Cruz': 3.9,
    'Santa Fé': 5.25,
    'Santiago del Estero': 4.94,
    'Tucuman': 4.35,
    'Tierra del Fuego': 3.82,
  };

  Map<String, double> consumosJson = {
    'Heladera': 125,
    'Freezer': 150,
    'Lampara Led': 9,
    'Lavarropas': 180,
    'Cafetera': 750,
    'Bomba 3/4HP': 750,
    'Cargador Cel': 5,
    'Notebook': 80,
    'Televisor LED': 80,
    'Router Wifi': 4,
    'Ventilador Techo': 60,
    'Ventilador Pie': 80,
    'Aire Acondicionado 2200Fg': 800,
  };
//Funciones de los modelos

  double get getValorFactura {
    return valorFactura;
  }

  Map<String, double> get getHsSolaresJson {
    return _hsSolaresJson;
  }

  set setValorFactura(double fact) {
    valorFactura = fact;
    notifyListeners();
  }

  set setRed(bool R) {
    Red = R;
    notifyListeners();
  }

  set setGrupo(bool G) {
    Grupo = G;
    notifyListeners();
  }

  //Devuelve Lista <String>

  List<String> get getUbicaciones {
    for (String key in _hsSolaresJson.keys) {
      //key = Capital Federal
      //${_hsSolaresJson[key]} 5.1
      Ubicaciones.add(key);
    }
    return Ubicaciones;
  }

  List<String> get getConsumos {
    for (String key in consumosJson.keys) {
      //key = Capital Federal
      //${_hsSolaresJson[key]} 5.1
      Consumos.add(key);
    }
    return Consumos;
  }

  kitAislado() {}

  kitRed() {
    EnergiaDiaria = ((valorFactura / 30) * 1000) / 2; // Meta Ahorro 50%
    for (String key in _hsSolaresJson.keys) {
      //key = Capital Federal
      //${_hsSolaresJson[key]} 5.1
      //Devuelvo las horas solares seleccionadas
      if (key == UbicacionSeleccionada) {
        //print(UbicacionSeleccionada + ': ' + _hsSolaresJson[key].toString());
        Insolacion = _hsSolaresJson[key]?.toDouble();
      }
      ;
    }

    PotenciaPaneles = (EnergiaDiaria / Insolacion! / 0.73);

    if (PotenciaPaneles <= 540) {
      //12v
      TensionInversor = 12;
      PanelSeleccionado = '400Wp';
      CantReg = 1;
      CantPanel = CantReg;
    } else if (PotenciaPaneles >= 1080) {
      //48V
      TensionInversor = 48;
      PanelSeleccionado = '360Wp';
      if (PotenciaPaneles <= 2160) {
        // 1 regulador 6 paneles
        CantReg = 1;
        CantPanel = CantReg * 6;
      } else if (PotenciaPaneles <= 4320) {
        // 2 reguladores 12 paneles
        CantReg = 2;
        CantPanel = CantReg * 6;
      } else if (PotenciaPaneles <= 6480) {
        // 3 reguladores 18 paneles
        CantReg = 3;
        CantPanel = CantReg * 6;
      } else {
        // 4 reguladores 24 paneles
        CantReg = 4;
        CantPanel = CantReg * 6;
      }
    } else {
      //24V
      TensionInversor = 24;
      PanelSeleccionado = '360Wp';
      CantReg = 1;
      CantPanel = CantReg * 3;
    }
    BancoBateria = (EnergiaDiaria / 0.85 / TensionInversor) * 2; // 50% DOD

    print('Insolación: ' + Insolacion.toString());
    print('Energía Diaria: ' + EnergiaDiaria.toString());
    print('Potencia Paneles: ' + PotenciaPaneles.toString());
    print('Banco de Batería: ' +
        BancoBateria.toString() +
        ' Con banco de: ' +
        TensionInversor.toString());

    Kit.add(Text('Panel: ' + PanelSeleccionado.toString(),
        style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));
    Kit.add(const Divider());

    // Kit = [
    //   'Panel: ' +
    // ]
    // terminarrrrrrrrrrrrrrrrr
  }

  //Agrega nuevo registro al Map
  AgregaConsumo(String consumo, double valor) {
    //_consumosSeleccionados.update("$consumo", (value) => valor);
    _consumosSeleccionados.addAll({consumo: valor});
  }

  //Elimina registro por medio de la key
  EliminaConsumo(String consumo) {
    _consumosSeleccionados.remove(consumo);
  }
}
