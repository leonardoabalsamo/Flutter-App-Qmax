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
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              const ListaTipo(),
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                "assets/images/instalacion.png",
                height: 140.0,
                width: 160.0,
              ),
              const SizedBox(
                height: 5,
              ),
              const ListaRed(),
              Image.asset(
                "assets/images/inversor_iq.png",
                height: 120.0,
                width: 180.0,
              ),
              const ListaSolucion(),
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                "assets/images/logo_bateria_t.png",
                height: 70.0,
                width: 70.0,
              ),
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text(
          'SOLUCION PLANTEADA',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfigPage()),
          );
        },
        label: const Text('Obtener Configuración'),
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
      style: const TextStyle(
        fontSize: 20,
      ),
      borderRadius: BorderRadius.circular(10),
      value: dropdownValue,
      isDense: true,
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
          child: SizedBox(
              child: Text(
            value,
            textAlign: TextAlign.center,
          )),
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
      style: const TextStyle(
        fontSize: 20,
      ),
      borderRadius: BorderRadius.circular(10),
      value: dropdownValue,
      isDense: true,
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
          child: SizedBox(
              child: Text(
            value,
            textAlign: TextAlign.center,
          )),
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
      style: const TextStyle(
        fontSize: 20,
      ),
      borderRadius: BorderRadius.circular(10),
      value: dropdownValue,
      isDense: true,
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
          child: SizedBox(
              child: Text(
            value,
            textAlign: TextAlign.center,
          )),
        );
      }).toList(),
    );
  }
}
