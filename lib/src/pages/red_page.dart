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
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Verifique el consumo en la factura ',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/fact.jpeg',
                      height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    slideBarEnergia(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Seleccione la Ubicación:  ',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListaUbicaciones(),
                  ],
                ))),
        appBar: dimAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            print('VALOR FACTURA: ' +
                dimensionamientoProvider.valorFactura.toString());
            if (dimensionamientoProvider.valorFactura != 0 &&
                dimensionamientoProvider.UbicacionSeleccionada != "") {
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
}

AppBar dimAppBar(BuildContext context) {
  var dimensionamientoProvider =
      Provider.of<DimensionamientoProvider>(context, listen: true);
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
          dimensionamientoProvider.Red = false;
          dimensionamientoProvider.Grupo = false;
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
