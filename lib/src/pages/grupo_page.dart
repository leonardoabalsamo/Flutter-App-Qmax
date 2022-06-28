import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/kit_page_dimensionamiento.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

import '../models/class_app.dart';

class GrupoPage extends StatefulWidget {
  const GrupoPage({
    Key? key,
  }) : super(key: key);

  @override
  _GrupoPage createState() => _GrupoPage();
}

class _GrupoPage extends State<GrupoPage> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return Scaffold(
        body: ListConsumos(),
        appBar: dimAppBar(context),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  dimensionamientoProvider.Reset();
                },
                child: Text('Reset')),
            FloatingActionButton.extended(
              onPressed: () async {
                if (dimensionamientoProvider.totalEnergia == 0 ||
                    dimensionamientoProvider.UbicacionSeleccionada ==
                        'Ubicación') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      contentPadding: const EdgeInsets.all(10.0),
                      content: Row(
                        children: const <Widget>[
                          Expanded(
                            child: Text(
                              "Debe seleccionar al menos una opción",
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
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  );
                } else {
                  dimensionamientoProvider.kitAislado();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KitPage()),
                  );
                }
              },
              label: const Text(
                'Continuar',
              ),
              icon: const Icon(Icons.arrow_forward),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

AppBar dimAppBar(BuildContext context) {
  var dimensionamientoProvider =
      Provider.of<DimensionamientoProvider>(context, listen: true);
  return AppBar(
    title: const Text(
      'DIMENSIONAMIENTO GRUPO',
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
                        Navigator.of(context).pop();
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
          dimensionamientoProvider.Reset();
        }),
  );
}

class ListConsumos extends StatefulWidget {
  ListConsumos({Key? key}) : super(key: key);

  @override
  State<ListConsumos> createState() => _ListConsumosState();
}

class _ListConsumosState extends State<ListConsumos> {
  double valor = 0;

  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    var indicesSeleccionados = [];
    var contadoritem = dimensionamientoProvider.consumosJson.length;
    dimensionamientoProvider.inicioSeleccion();

    return Card(
      elevation: 20.0,
      margin: EdgeInsets.only(bottom: 80),
      child: Column(children: [
        Text(
          'Seleccione la Ubicación:  ',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        ListaUbicaciones(),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: contadoritem,
          itemBuilder: (context, index) {
            return Column(children: [
              CheckboxListTile(
                  activeColor: const Color.fromRGBO(64, 151, 200, 1),
                  title: Text(
                      '${dimensionamientoProvider.consumosJson.keys.elementAt(index)}'),
                  subtitle: Text(
                      '${dimensionamientoProvider.consumosJson.values.elementAt(index)} W'),
                  value: dimensionamientoProvider.seleccion[index],
                  selected: dimensionamientoProvider.seleccion[index],
                  onChanged: (bool? value) {
                    setState(() {
                      dimensionamientoProvider.seleccion[index] = value!;
                      valor = dimensionamientoProvider.consumosJson.values
                          .elementAt(index);

                      if (dimensionamientoProvider.seleccion.contains(index)) {
                        indicesSeleccionados.remove(index); // unselect
                        dimensionamientoProvider.Resta(valor);
                      }

                      if (!dimensionamientoProvider.seleccion.contains(index)) {
                        indicesSeleccionados.add(index); // select
                        dimensionamientoProvider.Suma(valor);
                      }
                    });
                    //Siempre SUMA, HAY QUE VERLO
                    print('Valor: ' + '${valor}');
                    print('TOTAL : ' +
                        '${dimensionamientoProvider.totalEnergia}');
                  }),
              Divider(),
            ]);
          },
        )),
      ]),
    );
  }
}
