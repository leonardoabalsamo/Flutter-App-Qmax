import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';

import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
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
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
          ),
          const SizedBox(
            height: 5,
          ),
          ListaInversores(),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          Expanded(
            child: Image.asset(
              'assets/images/inv.png',
              height: 140,
            ),
          ),
          ListaBaterias(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('assets/images/vision.png'),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/pylontech.png'),
                ),
                Expanded(
                  child: Image.asset('assets/images/bateria.png'),
                ),
              ],
            ),
          ),
          ListaTensiones(),
          const Expanded(
            child: SizedBox(
              height: 10,
            ),
          )
        ],
      )),
      appBar: AppBar(
        title: const Text(
          'SELECCION DE MODELO',
          style: TextStyle(fontSize: 12),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(10.0),
                    content: Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text(
                            "La selección no puede superar los 4 bancos de baterías en paralelo por desbalance en carga y descarga. ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                          child: const Text('Aceptar'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.help))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (seleccionProvider.validacion()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedioPage()),
            );
          } else {
            await _showError(context);
          }
        },
        label: const Text(
          'Continuar',
        ),
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future _showError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        content: Row(
          children: const <Widget>[
            Expanded(
              child: Text(
                "No es posible la combinación indicada. Reintente",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
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
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    var invBusca = Inversor(id: 0, modelo: "", tensionNominal: 0, potencia: 0);
    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          seleccionProvider.inversor = newValue;
          seleccionProvider.setInversor = invBusca.buscaInversor(newValue);
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

class ListaBaterias extends StatefulWidget {
  const ListaBaterias({Key? key}) : super(key: key);

  @override
  State<ListaBaterias> createState() => _ListaBaterias();
}

class _ListaBaterias extends State<ListaBaterias> {
  String dropdownValue = 'SELECCIONE LA BATERIA';

  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    String inv = seleccionProvider.inversor;

    var buscaBat = Bateria(
        id: 0,
        capacidad: 0,
        flote: 0,
        fondo: 0,
        modelo: "",
        tensionNominal: 0,
        tipo: "");
    if (inv == 'SELECCIONE EL INVERSOR') {
      return DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('SELECCIONE EL INVERSOR'),
      );
    } else {
      return DropdownButton<String>(
        style: const TextStyle(fontSize: 20, color: Colors.white),
        value: dropdownValue,
        isDense: true,
        borderRadius: BorderRadius.circular(10),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            seleccionProvider.bateria = newValue;
            seleccionProvider.setBateria = buscaBat.buscaBateria(newValue);
          });
        },
        items: <String>[
          'SELECCIONE LA BATERIA',
          'TROJAN T105',
          'TROJAN T605',
          'TROJAN 27TMX',
          'VISION 6FM200X',
          'VISION 6FM100X',
          'PYLONTECH US2000C',
          'PYLONTECH US3000C',
          'PYLONTECH PHANTOM-S',
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
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    String bat = seleccionProvider.bateria;
    String inv = seleccionProvider.inversor;
    if (inv == 'SELECCIONE EL INVERSOR') {
      return DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('SELECCIONE EL INVERSOR'),
      );
    }
    if (bat == 'SELECCIONE LA BATERIA') {
      return DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('SELECCIONE LA BATERIA'),
      );
    } else {
      return DropdownButton<String>(
        style: const TextStyle(fontSize: 20, color: Colors.white),
        value: dropdownValue,
        isDense: true,
        borderRadius: BorderRadius.circular(10),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            seleccionProvider.cantBat = newValue;
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
}
