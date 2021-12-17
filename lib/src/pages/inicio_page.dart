import 'package:flutter/material.dart';
import 'package:qmax_inst/src/models/seleccion_model.dart';
import 'medio_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
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
              const ListaInversores(),
              Image.asset(
                "assets/images/inv.png",
                height: 200.0,
                width: 200.0,
              ),
              const ListaBaterias(),
              const ListaTipo(),
              Image.asset(
                "assets/images/bateria.png",
                height: 200.0,
                width: 200.0,
              )
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text(
          'Configuración Inversor SPD',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedioPage(
                      inversor: Seleccion.inversor,
                      bateria: Seleccion.bateria,
                      cantidad: Seleccion.cantidad,
                    )),
          );
        },
        backgroundColor: Colors.blue.shade600,
        label: const Text('Continuar',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ListaInversores extends StatefulWidget {
  const ListaInversores({Key? key}) : super(key: key);

  @override
  State<ListaInversores> createState() => _ListaInversores();
}

class _ListaInversores extends State<ListaInversores> {
  String dropdownValue = 'SELECCIONE EL INVERSOR';
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
        color: Colors.blue.shade600,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          Seleccion.inversor = newValue;
        });
      },
      items: <String>[
        'SELECCIONE EL INVERSOR',
        'QM-1212-SPD',
        'QM-2312-SPD',
        'QM-1224-SPD',
        'QM-2324-SPD',
        'QM-1248-SPD',
        'QM-2348-SPD',
        'QM-3524-SPD',
        'QM-4548-SPD'
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

class ListaBaterias extends StatefulWidget {
  const ListaBaterias({Key? key}) : super(key: key);

  @override
  State<ListaBaterias> createState() => _ListaBaterias();
}

class _ListaBaterias extends State<ListaBaterias> {
  String dropdownValue = 'SELECCIONE LA BATERIA';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          Seleccion.bateria = newValue;
        });
      },
      items: <String>[
        'SELECCIONE LA BATERIA',
        'TROJAN T105',
        'TROJAN T605',
        'VISION 6FM200X',
        'VISION 6FM100X',
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

class ListaTensiones extends StatefulWidget {
  const ListaTensiones({Key? key}) : super(key: key);

  @override
  State<ListaTensiones> createState() => _ListaTensiones();
}

class _ListaTensiones extends State<ListaTensiones> {
  String dropdownValue = 'SELECCIONE LA CANTIDAD';
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
          Seleccion.cantidad = newValue;
        });
      },
      items: <String>[
        'SELECCIONE LA CANTIDAD',
        '1',
        '2',
        '4',
        '6',
        '8',
        '12',
        '16',
        '32'
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
