//import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:qmax_inst/sql_helper.dart';

class DimensionamientoProvider extends ChangeNotifier {
  //Declaración de Variables

  int clave = 18355;

  bool Red = false;
  bool Grupo = false;

  int PanelSeleccionado = 0;
  String UbicacionSeleccionada = '';

  var seleccion = <bool>[];
  var texto = <Widget>[];

  //Dropdown Button de seleccion de consumos
  var potenciaConsumo = <double>[];
  var cantidad = <int>[];
  var cantidadHoras = <int>[];

  //Suma de consumos parcial
  //potencia de consumo X Cantidad
  double parcial = 0;
  //Cantidad de horas de uso del consumo parcial
  double horas = 0;

  //Suma total de energía
  double sumaEnergia = 0;

  //Potencia necesaria para el inversor
  double potenciaTotal = 0;
  int potenciaInversor = 0;

  int potenciaTotalPaneles = 0;
  int cantidadPaneles = 0;

  //Selección de consumos
  var indicesSeleccionados = <int>[];

  double valorFactura = 0;
  double EnergiaDiaria = 0;
  double metaDiaria = 0;
  double TensionInversor = 0;
  num CantReg = 0;
  num CantPanel = 0;
  double? Insolacion = 0;
  double PotenciaPaneles = 0;
  double BancoBateria = 0;
  double totalEnergia = 0;
  double meta = 0;
  int dias = 0;
  double valorKit = 0;
  double valorInst = 0;

  var Ubicaciones = <String>[
    'SELECCIONE',
    'Buenos Aires',
    'Catamarca',
    'Cordoba',
    'Corrientes',
    'Chaco',
    'Chubut',
    'Entre Rios',
    'Formosa',
    'Jujuy',
    'La Pampa',
    'La Rioja',
    'Mendoza',
    'Misiones',
    'Neuquén',
    'Rio Negro',
    'Salta',
    'San Juan',
    'San Luis',
    'Santa Cruz',
    'Santa Fé',
    'Santiago del Estero',
    'Tucuman',
    'Tierra del Fuego',
  ];

  var Kit = <Widget>[];

//Mapa usado para determinar las Hs Solares Pico
  Map<String, double> hsSolaresJson = {
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

//Mapa usado para determinar potencia de consumos
  Map<String, int> consumosJson = {
    'Heladera': 120,
    'Freezer': 150,
    'Lampara Led': 9,
    'Lavarropas': 500,
    'Cafetera': 1000,
    'Bomba 1HP': 750,
    'Cargador Cel': 5,
    'Notebook': 80,
    'Televisor LED 32': 80,
    'Televisor LED 40': 100,
    'Router Wifi': 100,
    'Ventilador Techo': 120,
    'Ventilador Pie': 80,
    'AA 2200 Fg': 900,
    'AA 3500 Fg': 1500,
  };

  kitAislado() {
    texto.clear();
    //datos ->
    //Insolacion //sumaEnergia //ubicacion
    // if (Insolacion == 0.0) {
    //   Insolacion = 5.03;
    // }

    PotenciaPaneles = (sumaEnergia / 0.85 / Insolacion! / 0.73);
    cantidadPaneles = (PotenciaPaneles ~/ PanelSeleccionado);
    potenciaTotalPaneles = cantidadPaneles * PanelSeleccionado;

    if (potenciaTotalPaneles <= 540) {
      //12v
      TensionInversor = 12;
      CantReg = 1;
    } else if (potenciaTotalPaneles >= 1080) {
      //48V
      TensionInversor = 48;
      if (potenciaTotalPaneles <= 2160) {
        // 1 regulador 6 paneles
        CantReg = 1;
      } else if (potenciaTotalPaneles <= 4320) {
        // 2 reguladores 12 paneles
        CantReg = 2;
      } else if (potenciaTotalPaneles <= 6480) {
        // 3 reguladores 18 paneles
        CantReg = 3;
      } else {
        // 4 reguladores 24 paneles
        CantReg = 4;
      }
    } else {
      //24V
      TensionInversor = 24;
      CantReg = 1;
    }
    var energiaGenerada = potenciaTotalPaneles * Insolacion!; //* 0.73;

    BancoBateria = (sumaEnergia / 0.85 / TensionInversor) * 2; // 50% DOD

    potenciaInversor = (potenciaTotal * 0.8).toInt();

    valorKit = (0.82 * potenciaTotalPaneles) +
        (0.3 * TensionInversor * BancoBateria) +
        (potenciaInversor) +
        (potenciaTotalPaneles * 0.60);

    valorInst = 0.2 * valorKit;

    /*Valores*/ //PERMITIR MODIFICAR LOS COSTOS
    /*
    USD / W Panel USD 0.82
    USD / W Bateria USD  0.30
    USD / W Inverter USD 1 dl
    USD / W MPPT USD 0.60 dl
    */
    texto.add(Text('Cantidad Paneles:  ' + cantidadPaneles.toString() + ' u.'));
    texto.add(Divider());
    texto.add(Text(
        'Potencia Paneles:  ' + (PotenciaPaneles.toInt()).toString() + ' W'));
    texto.add(Divider());
    texto.add(
        Text('Cantidad Reguladores:  ' + CantReg.round().toString() + ' u.'));
    texto.add(Divider());

    texto.add(Text('Energía Diaria Generada:  ' +
        (energiaGenerada.toInt()).toString() +
        ' Wh'));
    texto.add(Divider());
    texto.add(Text('Insolación:  ' + Insolacion!.toString() + ' Hs '));
    texto.add(Divider());
    texto.add(SizedBox(
      height: 30,
    ));
    texto.add(Text(
      'Consumo de Energía',
      style: TextStyle(fontSize: 25),
    ));
    texto.add(SizedBox(
      height: 10,
    ));
    texto.add(Text('Energía Diaria Consumida:  ' +
        ((sumaEnergia ~/ 0.85).toInt()).toString() +
        ' Wh'));
    texto.add(Divider());

    texto.add(Text('Banco de Batería:  ' +
        (BancoBateria.toInt()).toString() +
        'Ah' +
        ' @ ' +
        (TensionInversor.toInt()).toString() +
        'V'));
    texto.add(Divider());

    texto.add(Text('Potencia Inversor:  ' +
        (potenciaInversor).toString() +
        'W @ ' +
        (TensionInversor.toInt()).toString() +
        'V'));
    texto.add(SizedBox(height: 20));

    texto.add(Divider(
      color: Colors.white,
      thickness: 3,
    ));
    texto.add(SizedBox(height: 20));

    texto.add(Text(
      'Valor Aprox. KIT:  USD ' + valorKit.toInt().toString() + ',00.- BNA',
      style: TextStyle(fontSize: 14),
    ));
    texto.add(Divider(
      color: Colors.white,
    ));
    texto.add(Text(
      'Valor Aprox. Instalación:  USD ' +
          valorInst.toInt().toString() +
          ',00.- BNA',
      style: TextStyle(fontSize: 14),
    ));
  }

  kitRed() {
    texto.clear();
    EnergiaDiaria = ((valorFactura / 30) * 1000);
    metaDiaria = EnergiaDiaria * meta;

    // if (Insolacion == 0.0) {
    //   Insolacion = 5.03;
    // }

    for (String key in hsSolaresJson.keys) {
      if (key == UbicacionSeleccionada) {
        Insolacion = hsSolaresJson[key]?.toDouble();
      }
      ;
    }

    PotenciaPaneles = (metaDiaria / 0.85 / Insolacion! / 0.73);

    cantidadPaneles = (PotenciaPaneles ~/ PanelSeleccionado);
    potenciaTotalPaneles = cantidadPaneles * PanelSeleccionado;

    if (potenciaTotalPaneles <= 540) {
      //12v
      TensionInversor = 12;
      CantReg = 1;
    } else if (potenciaTotalPaneles >= 1080) {
      //48V
      TensionInversor = 48;
      if (potenciaTotalPaneles <= 2160) {
        // 1 regulador 6 paneles
        CantReg = 1;
      } else if (potenciaTotalPaneles <= 4320) {
        // 2 reguladores 12 paneles
        CantReg = 2;
      } else if (potenciaTotalPaneles <= 6480) {
        // 3 reguladores 18 paneles
        CantReg = 3;
      } else {
        // 4 reguladores 24 paneles
        CantReg = 4;
      }
    } else {
      //24V
      TensionInversor = 24;
      CantReg = 1;
    }

    if (TensionInversor == 48) {
      potenciaInversor = 4000;
    } else {
      potenciaInversor = 2000;
    }

    BancoBateria = (EnergiaDiaria / 0.85 / TensionInversor) * 2; // 50% DOD

    valorKit = (0.82 * potenciaTotalPaneles) +
        (0.3 * TensionInversor * BancoBateria) +
        (potenciaInversor) +
        (potenciaTotalPaneles * 0.60);

    valorInst = 0.2 * valorKit;

    /*Valores*/ //PERMITIR MODIFICAR LOS COSTOS
    /*
    USD / W Panel USD 0.82
    USD / W Bateria USD  0.30
    USD / W Inverter USD 1 dl
    USD / W MPPT USD 0.60 dl
    */

    var energiaGenerada = potenciaTotalPaneles * Insolacion!; //* 0.73;

    texto.add(Text('Cantidad Paneles:  ' + cantidadPaneles.toString() + ' u.'));
    texto.add(Divider());
    texto.add(Text('Potencia Paneles:  ' +
        (potenciaTotalPaneles.toInt()).toString() +
        ' W'));
    texto.add(Divider());

    texto.add(
        Text('Cantidad Reguladores:  ' + CantReg.round().toString() + ' u.'));
    texto.add(Divider());
    texto.add(Text('Energía Diaria Generada:  ' +
        (energiaGenerada.toInt()).toString() +
        ' Wh'));
    texto.add(Divider());
    texto.add(Text('Insolación Promedio:  ' + Insolacion!.toString() + ' Hs '));
    texto.add(SizedBox(
      height: 30,
    ));

    //CONSUMO
    texto.add(Text(
      'Consumo de Energía',
      style: TextStyle(fontSize: 25),
    ));
    texto.add(SizedBox(
      height: 10,
    ));
    texto.add(Text('Energía Diaria Consumida:  ' +
        ((EnergiaDiaria ~/ 0.85).toString() + ' Wh')));

    texto.add(Divider());

    texto.add(Text('Banco de Batería:  ' +
        (BancoBateria.toInt()).toString() +
        'Ah' +
        ' @ ' +
        (TensionInversor.toInt()).toString() +
        'V'));
    texto.add(Divider());

    texto.add(
        Text('Meta de Ahorro:  ' + ((meta * 100).toInt()).toString() + '%'));
    texto.add(SizedBox(height: 20));

    texto.add(Divider(
      color: Colors.white,
      thickness: 3,
    ));
    texto.add(SizedBox(height: 20));
    texto.add(Text(
      'Valor Aprox. KIT:  USD ' + valorKit.toInt().toString() + ',00.- BNA',
      style: TextStyle(fontSize: 14),
    ));
    texto.add(Divider(
      color: Colors.white,
    ));

    texto.add(Text(
      'Valor Aprox. Instalación:  USD ' +
          valorInst.toInt().toString() +
          ',00.- BNA',
      style: TextStyle(fontSize: 14),
    ));
  }

  Suma(double v) {
    totalEnergia = totalEnergia + v;
  }

  Resta(double v) {
    totalEnergia = totalEnergia - v;
  }

//Inicializo indices
  inicioSeleccion() {
    for (int i = 0; i < consumosJson.length; i++) {
      seleccion.add(false);
    }
  }

//Inicializo los Dropdowns Cantidad y Hs
  inicializacion() {
    for (int i = 1; i < 12; i++) {
      cantidad.add(1);
    }
    for (int i = 1; i < 25; i++) {
      cantidadHoras.add(1);
    }
  }

//Reset de Energía e Indices seleccionados
  Reset() {
    totalEnergia = 0;
    inicioSeleccion();
  }

  void ResetConf() {
    UbicacionSeleccionada = '';
    PotenciaPaneles = 0;
    BancoBateria = 0;
    totalEnergia = 0;
    EnergiaDiaria = 0;
    valorFactura = 0;
    sumaEnergia = 0; //contador de energía
    potenciaTotal = 0; //contador potencia
    meta = 0;
    PanelSeleccionado = 0;
    valorKit = 0;
    valorFactura = 0;
    potenciaInversor = 0;
    potenciaTotalPaneles = 0;
    texto.clear();
    cantidad.clear();
    cantidadHoras.clear();
    seleccion.clear();

    Red = false;
    Grupo = false;

    notifyListeners();

    /*Vaciamos la BD de consumos*/
    //SQLHelper.deleteConsumos();
  }

  notificar(context) {
    notifyListeners();
  }
}
