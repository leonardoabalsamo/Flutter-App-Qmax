//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';
import '../models/class_app.dart';
import 'kit_page_dimensionamiento.dart';

class RedPage extends StatefulWidget {
  const RedPage({
    Key? key,
  }) : super(key: key);

  @override
  _RedPage createState() => _RedPage();
}

class _RedPage extends State<RedPage> {
  @override
  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return principal(context, dP);
  }

  Widget principal(BuildContext context, DimensionamientoProvider dP) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Verifique el consumo en la factura ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '(El valor debe ser mensual 30 días)',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/fact.jpeg',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    slideBarEnergia(),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Meta de Ahorro',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    slideBarMeta(),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Selección de Panel',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    slideBarPanel(),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 4,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          ' UBICACIÓN DE INSTALACIÓN ',
                          style: TextStyle(fontSize: 22, fontFamily: 'Roboto'),
                        ),
                        Icon(Icons.light_mode_outlined)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListaUbicaciones(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ))),
        appBar: dimAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (verificacion(context) == true) {
              //muestro meta de ahorro ->
              dP.kitRed();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KitPage()),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  bool verificacion(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: false);

    if (dP.valorFactura == 0) () => false;
    if (dP.UbicacionSeleccionada == "") () => false;
    if (dP.meta == 0) () => false;
    if (dP.PanelSeleccionado == 0) () => false;

    return true;
  }
}

AppBar dimAppBar(BuildContext context) {
  var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
  return AppBar(
    title: const Text(
      'DIMENSIONAMIENTO',
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
                        "La energía diaria consumida depende de la potencia (W) y tiempo de uso (kWh)",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Continuar'),
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
          dP.Red = false;
          dP.Grupo = false;
          dP.notificar(context);
        }),
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
              "¡Debe seleccionar todos los campos!",
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
