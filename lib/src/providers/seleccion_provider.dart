import 'package:flutter/material.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';

class SeleccionProvider extends ChangeNotifier {
  late Seleccion seleccionSeleccionada;

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

  late int cantidadSeleccionada;
  late String tipoSeleccionado;
  late String redSeleccionada;
  late String solucionSeleccionada;

  Seleccion get getSeleccion {
    return seleccionSeleccionada;
  }

  set setSeleccion(Seleccion S) {
    seleccionSeleccionada = S;
    notifyListeners();
  }

//Funciones de los modelos

  Bateria get getBateria {
    return bateriaSeleccionada;
  }

  DropdownButton get getListaInversores {
    return listaInversores();
  }

  DropdownButton get getListaBaterias {
    return listaBaterias();
  }

  DropdownButton get getListaTensiones {
    return listaTensiones();
  }

  DropdownButton get getListaTipo {
    return listaTipo();
  }

  DropdownButton get getListaRed {
    return listaRed();
  }

  DropdownButton get getListaSolucion {
    return listaSolucion();
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

// Listas para los Dropdowns
  var modeloInv = <String>[
    'SELECCIONE EL INVERSOR',
    'QM-1212-SPD',
    'QM-2312-SPD',
    'QM-1224-SPD',
    'QM-2324-SPD',
    'QM-1248-SPD',
    'QM-2348-SPD',
    'QM-3524-SPD',
    'QM-4548-SPD'
  ];

  var modeloBat = <String>[
    'SELECCIONE LA BATERIA',
    'TROJAN T105',
    'TROJAN T605',
    'VISION 6FM200X',
    'VISION 6FM100X'
  ];

  var modeloTension = <String>[
    'SELECCIONE LA CANTIDAD',
    '1',
    '2',
    '4',
    '6',
    '8',
    '12',
    '16',
    '32'
  ];

// Listas Desplegables
  DropdownButton<String> listaInversores() {
    inversorSeleccionado.creaInversores();
    String dropdownValue = 'SELECCIONE EL INVERSOR';
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        setInversor = inversorSeleccionado.buscaInversor(newValue);
        print("You selected $newValue");
        dropdownValue = newValue.toString();

        // setState(() {
        //   //dropdownValue = inversorSeleccionado.modeloInversor;
        // });
        setState((() {}));
      },
      items: modeloInv.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> listaBaterias() {
    bateriaSeleccionada.creaBaterias();
    String dropdownValue = 'SELECCIONE LA BATERIA';
    bateriaSeleccionada;
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        setBateria = bateriaSeleccionada.buscaBateria(newValue);

        // setState(() {
        //   dropdownValue = bateriaSeleccionada.modeloBateria;

        //   notifyListeners();
        // });
        setState((() {}));
      },
      items: modeloBat.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> listaTensiones() {
    cantidadSeleccionada = 0;
    String dropdownValue = 'SELECCIONE LA CANTIDAD';
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        // setState(() {
        //   cantidadSeleccionada = int.parse(newValue!);
        //   dropdownValue = newValue;

        //   notifyListeners();
        // });
        setState((() {}));
      },
      items: modeloTension.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> listaTipo() {
    String dropdownValue = 'TIPO DE INSTALACION';
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        // setState(() {
        //    dropdownValue = newValue!;
        //    tipoSeleccionado = newValue;
        // });
        setState((() {}));
      },
      items: <String>[
        'TIPO DE INSTALACION',
        'VEHICULOS',
        'ESTACIONARIA',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> listaRed() {
    String dropdownValue = 'RED ELECTRICA';
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        // setState(() {
        //   dropdownValue = newValue!;
        //   redSeleccionada = newValue;
        // });
        setState((() {}));
      },
      items: <String>[
        'RED ELECTRICA',
        'SI',
        'NO',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> listaSolucion() {
    String dropdownValue = 'TIPO DE SOLUCION';
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        setState((() {}));
      },
      items: <String>[
        'TIPO DE SOLUCION',
        'BACKUP',
        'AUTOCONSUMO',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.white.withOpacity(0.8),
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

// Metodos para las pages

  bool validacion() {
    num aux;

    aux = inversorSeleccionado.tensionNominalInversor /
        bateriaSeleccionada.tensionNominalBateria;

    if (cantidadSeleccionada == aux ||
        cantidadSeleccionada == (aux * 2) ||
        cantidadSeleccionada == (aux * 3) ||
        cantidadSeleccionada == (aux * 4)) {
      return true;
    } else {
      return false;
    }
  }

  void setState(Null Function() param0) {}
}
