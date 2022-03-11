import 'package:flutter/material.dart';
import '../models/seleccion_model.dart';
import 'config_page.dart';

class MedioPage extends StatefulWidget {
  const MedioPage({
    Key? key,
  }) : super(key: key);

  @override
  _MedioPage createState() => _MedioPage();
}

class _MedioPage extends State<MedioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          Container(
            padding: const EdgeInsets.all(26.0),
          ),
          Column(
            children: [
              const ListaTipo(),
              Image.asset(
                "assets/images/instalacion.png",
                height: 200.0,
                width: 200.0,
              ),
              const ListaRed(),
              Image.asset(
                "assets/images/inversor_iq.png",
                height: 200.0,
                width: 200.0,
              ),
              const ListaSolucion(),
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text(
          'Solución Instalada',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      backgroundColor: Colors.black38,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfigPage()),
          );
        },
        label: const Text('Obtener Configuración'),
        backgroundColor: Colors.blue.shade600,
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ListaTipo extends StatefulWidget {
  const ListaTipo({Key? key}) : super(key: key);

  @override
  State<ListaTipo> createState() => _ListaTipo();
}

class _ListaTipo extends State<ListaTipo> {
  String dropdownValue = 'TIPO DE INSTALACION';
  @override
  Widget build(BuildContext context) {
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
        setState(() {
          dropdownValue = newValue!;
          Seleccion.tipoInstalacion = newValue;
        });
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
}

class ListaRed extends StatefulWidget {
  const ListaRed({Key? key}) : super(key: key);

  @override
  State<ListaRed> createState() => _ListaRed();
}

class _ListaRed extends State<ListaRed> {
  String dropdownValue = 'RED ELECTRICA';
  @override
  Widget build(BuildContext context) {
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
        setState(() {
          dropdownValue = newValue!;
          Seleccion.red = newValue;
        });
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
}

class ListaSolucion extends StatefulWidget {
  const ListaSolucion({Key? key}) : super(key: key);

  @override
  State<ListaSolucion> createState() => _ListaSolucion();
}

class _ListaSolucion extends State<ListaSolucion> {
  String dropdownValue = 'TIPO DE SOLUCION';
  @override
  Widget build(BuildContext context) {
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
        setState(() {
          dropdownValue = newValue!;
          Seleccion.tipoSolucion = newValue;
        });
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
}
