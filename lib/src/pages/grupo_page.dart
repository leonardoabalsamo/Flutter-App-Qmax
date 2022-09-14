import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/sql_helper.dart';
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
                  setState(() {
                    dimensionamientoProvider.Reset();
                  });
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
    var contadoritem = dimensionamientoProvider.consumosJson.length;
    dimensionamientoProvider.inicioSeleccion();

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      //elevation: 20.0,
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
              child: Column(
            children: [
              SizedBox(
                height: 25,
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
                height: 5,
              ),
              Divider(
                color: Colors.white,
                thickness: 4,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.light_outlined,
                  ),
                  Text(
                    ' SELECCIÓN DE CONSUMOS ',
                    style: TextStyle(fontSize: 22, fontFamily: 'Roboto'),
                  ),
                  Icon(Icons.batch_prediction_rounded)
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          )),
          Expanded(
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: contadoritem,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      dense: true,
                      activeColor: Color.fromARGB(255, 6, 0, 0),
                      tileColor: Color.fromARGB(255, 255, 255, 255),
                      isThreeLine: true, // false hace mas grande el casillero
                      secondary: Icon(Icons.add_circle_outline_sharp),
                      selectedTileColor: Colors.white,
                      side: BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      contentPadding: EdgeInsets.all(8),

                      //NOMBRE DEL CONSUMO
                      title: Text(
                        '${dimensionamientoProvider.consumosJson.keys.elementAt(index)}',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),

                      //POTENCIA CONSUMIDA
                      subtitle: Text(
                        'Consumo: ${dimensionamientoProvider.consumosJson.values.elementAt(index)} Wh',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      value: dimensionamientoProvider.seleccion[index],
                      selected: dimensionamientoProvider.seleccion[index],
                      onChanged: (bool? value) {
                        setState(() {
                          // //SEGUIR CON ESTE TEMA; HAY QUE EVITAR QUE SUME SIEMPRE;
                          dimensionamientoProvider.seleccion[index] =
                              value!; // aca arroja true o false nada más

                          //Me guardo el valor ->
                          valor = dimensionamientoProvider.consumosJson.values
                              .elementAt(index)
                              .toDouble();

                          if (dimensionamientoProvider.indicesSeleccionados
                              .contains(index)) {
                            dimensionamientoProvider.indicesSeleccionados
                                .remove(index); // borra
                            dimensionamientoProvider.Resta(valor);
                            SQLHelper.deleteConsumo(dimensionamientoProvider
                                .consumosJson.keys
                                .elementAt(index));
                            print('ESTABA SELECCIONADO!!!!!!!!! Y LO RESTA');
                            print('Valor: ' + '${valor}');
                            print('TOTAL : ' +
                                '${dimensionamientoProvider.totalEnergia}');
                          }

                          if (!dimensionamientoProvider.indicesSeleccionados
                              .contains(index)) {
                            dimensionamientoProvider.indicesSeleccionados
                                .add(index); // select
                            dimensionamientoProvider.Suma(valor);
                            SQLHelper.createConsumo(
                                dimensionamientoProvider.consumosJson.keys
                                    .elementAt(index),
                                dimensionamientoProvider.consumosJson.values
                                    .elementAt(index));
                            print('NO ESTABA SELECCIONADO Y LO SUMA');

                            print('Valor: ' + '${valor}');
                            print('TOTAL : ' +
                                '${dimensionamientoProvider.totalEnergia}');
                          }
                        });
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );

    // return Card(
    //   //elevation: 20.0,
    //   margin: EdgeInsets.only(bottom: 80),
    //   child: Column(
    //     children: [
    //       Expanded(
    //           flex: 1,
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Icon(Icons.location_on),
    //                   Text(
    //                     ' UBICACIÓN DE INSTALACIÓN ',
    //                     style: TextStyle(fontSize: 22, fontFamily: 'Roboto'),
    //                   ),
    //                   Icon(Icons.light_mode_outlined)
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 30,
    //               ),
    //               ListaUbicaciones(),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Divider(
    //                 color: Colors.white,
    //                 thickness: 4,
    //                 indent: 20,
    //                 endIndent: 20,
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Icon(
    //                     Icons.light_outlined,
    //                   ),
    //                   Text(
    //                     ' SELECCIÓN DE CONSUMOS ',
    //                     style: TextStyle(fontSize: 22, fontFamily: 'Roboto'),
    //                   ),
    //                   Icon(Icons.batch_prediction_rounded)
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //             ],
    //           )),
    //       Expanded(
    //         flex: 2,
    //         child: ListView.builder(
    //           itemCount: contadoritem,
    //           itemBuilder: (context, index) {
    //             return CheckboxListTile(
    //                 dense: true,
    //                 activeColor: const Color.fromRGBO(64, 151, 200, 1),
    //                 tileColor: Color.fromRGBO(64, 151, 200, 1),
    //                 isThreeLine: true, // false hace mas grande el casillero
    //                 secondary: Icon(Icons.add_circle_outline_sharp),
    //                 selectedTileColor: Colors.white,
    //                 side: BorderSide(
    //                     width: 17.0, color: Color.fromARGB(255, 255, 255, 255)),
    //                 contentPadding: EdgeInsets.all(8),

    //                 //NOMBRE DEL CONSUMO
    //                 title: Text(
    //                   '${dimensionamientoProvider.consumosJson.keys.elementAt(index)}',
    //                   style: TextStyle(fontSize: 20),
    //                   textAlign: TextAlign.center,
    //                 ),

    //                 //POTENCIA CONSUMIDA
    //                 subtitle: Text(
    //                   'Consumo: ${dimensionamientoProvider.consumosJson.values.elementAt(index)} Wh',
    //                   style: TextStyle(fontSize: 14),
    //                   textAlign: TextAlign.center,
    //                 ),
    //                 value: dimensionamientoProvider.seleccion[index],
    //                 selected: dimensionamientoProvider.seleccion[index],
    //                 onChanged: (bool? value) {
    //                   setState(() {
    //                     // //SEGUIR CON ESTE TEMA; HAY QUE EVITAR QUE SUME SIEMPRE;
    //                     dimensionamientoProvider.seleccion[index] =
    //                         value!; // aca arroja true o false nada más

    //                     //Me guardo el valor ->
    //                     valor = dimensionamientoProvider.consumosJson.values
    //                         .elementAt(index)
    //                         .toDouble();

    //                     if (dimensionamientoProvider.indicesSeleccionados
    //                         .contains(index)) {
    //                       dimensionamientoProvider.indicesSeleccionados
    //                           .remove(index); // borra
    //                       dimensionamientoProvider.Resta(valor);
    //                       SQLHelper.deleteConsumo(dimensionamientoProvider
    //                           .consumosJson.keys
    //                           .elementAt(index));
    //                       print('ESTABA SELECCIONADO!!!!!!!!! Y LO RESTA');
    //                       print('Valor: ' + '${valor}');
    //                       print('TOTAL : ' +
    //                           '${dimensionamientoProvider.totalEnergia}');
    //                     }

    //                     if (!dimensionamientoProvider.indicesSeleccionados
    //                         .contains(index)) {
    //                       dimensionamientoProvider.indicesSeleccionados
    //                           .add(index); // select
    //                       dimensionamientoProvider.Suma(valor);
    //                       SQLHelper.createConsumo(
    //                           dimensionamientoProvider.consumosJson.keys
    //                               .elementAt(index),
    //                           dimensionamientoProvider.consumosJson.values
    //                               .elementAt(index));
    //                       print('NO ESTABA SELECCIONADO Y LO SUMA');

    //                       print('Valor: ' + '${valor}');
    //                       print('TOTAL : ' +
    //                           '${dimensionamientoProvider.totalEnergia}');
    //                     }
    //                   });
    //                 });
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
