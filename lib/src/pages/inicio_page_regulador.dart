import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/config_page.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';

import '../models/bateria_model.dart';
import '../models/class_app.dart';
//import '../widgets/menu_lateral.dart';

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
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return Scaffold(
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            cardBaterias(context),
            cardNominal(context),
            cardCantidades(context),
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
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                sP.ResetConfigRegulador();
                sP.notificar(context);
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            sP.regulador = true;
            if (sP.validacionReg()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigPage()),
              );
            } else {
              await showError(context);
            }
          },
          label: const Text(
            'Continuar',
          ),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

dimAppBar(BuildContext context) {
  return AppBar(
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
  );
}

Widget cardCantidades(context) {
  var sP = Provider.of<SeleccionProvider>(context, listen: true);

  if (sP.tensionBanco == '') {
    return SizedBox();
  } else {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(10),
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'CANTIDAD DE BATERÍAS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListaCantidadBat(),
            SizedBox(
              height: 20,
            )
          ],
        )));
  }
}

Widget cardBaterias(context) {
  return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'MODELO DE BATERÍAS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Image.asset(
            'assets/images/bateria.png',
            height: 120,
          ),
          ListaBateriasReg(),
          SizedBox(
            height: 20,
          )
        ],
      )));
}

Widget cardNominal(context) {
  var sP = Provider.of<SeleccionProvider>(context, listen: true);

  if (sP.bateria == '') {
    return SizedBox();
  } else {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(10),
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'TENSION DE BATERÍAS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListaNominal(),
            SizedBox(
              height: 20,
            )
          ],
        )));
  }
}
