import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/config_page.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';

import '../models/bateria_model.dart';

class InicioPageRegulador extends StatefulWidget {
  const InicioPageRegulador({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageReguladorState createState() => _InicioPageReguladorState();
}

class _InicioPageReguladorState extends State<InicioPageRegulador> {
  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);

    if (seleccionProvider.bateria != 'SELECCIONE LA BATERIA') {
      if (seleccionProvider.cantBat != 'SELECCIONE LA CANTIDAD') {
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
              Expanded(
                child: Image.asset(
                  'assets/images/mpptdisplay.png',
                  height: 150,
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
                      child: Image.asset('assets/images/bateria.png'),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
              ListaTensiones(),
              Expanded(
                flex: 2,
                child: Image.asset('assets/images/QM-LI10048-E.png'),
              ),
              ListaNominal(),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
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
              if (seleccionProvider.validacionReg()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfigPage()),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      } else {
        //Entra por aca
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
              Expanded(
                child: Image.asset(
                  'assets/images/mpptdisplay.png',
                  height: 150,
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
                      child: Image.asset('assets/images/QM-LI10048-E.png'),
                    ),
                    Expanded(
                      child: Image.asset('assets/images/bateria.png'),
                    ),
                  ],
                ),
              ),
              ListaTensiones(),
              //ListaNominal(),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
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
              if (seleccionProvider.validacionReg()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfigPage()),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }
    } else {
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
            Expanded(
              child: Image.asset(
                'assets/images/mpptdisplay.png',
                height: 150,
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
                    child: Image.asset('assets/images/QM-LI10048-E.png'),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/bateria.png'),
                  ),
                ],
              ),
            ),
            //ListaTensiones(),
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
            if (seleccionProvider.validacionReg()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigPage()),
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

    var buscaBat = Bateria(
        id: 0,
        capacidad: 0,
        flote: 0,
        fondo: 0,
        modelo: "",
        tensionNominal: 0,
        tipo: "");

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
        //'QM-LI10048-E',
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
            seleccionProvider.cantBat = dropdownValue;
            seleccionProvider.notifyListeners();
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

class ListaNominal extends StatefulWidget {
  const ListaNominal({Key? key}) : super(key: key);

  @override
  State<ListaNominal> createState() => _ListaNominal();
}

class _ListaNominal extends State<ListaNominal> {
  String dropdownValue = 'SELECCIONE LA TENSION';
  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);

    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          seleccionProvider.tensionBanco = dropdownValue;
          seleccionProvider.notifyListeners();
        });
      },
      items: <String>[
        'SELECCIONE LA TENSION',
        '12',
        '24',
        '48',
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
