import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/sql_helper.dart';
import 'package:qmax_inst/src/pages/kit_page_dimensionamiento.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';
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
                    _resetConsumo(context);
                  });
                },
                child: Text('Reset')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    print("Suma parcial: " +
                        '${dimensionamientoProvider.sumaEnergia}');
                  });
                },
                child: Text('Imprime')),
            FloatingActionButton.extended(
              onPressed: () async {
                if (dimensionamientoProvider.totalEnergia == 0 ||
                    dimensionamientoProvider.UbicacionSeleccionada ==
                        'Ubicación') {
                  errorSeleccion(context);
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

  void _resetConsumo(context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: false);
    dimensionamientoProvider.seleccion.clear();
    dimensionamientoProvider.EnergiaDiaria = 0;
    dimensionamientoProvider.sumaEnergia = 0; //contador de energía
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
            dimensionamientoProvider.notifyListeners();
          }),
    );
  }
}

class ListConsumos extends StatefulWidget {
  ListConsumos({Key? key}) : super(key: key);

  @override
  State<ListConsumos> createState() => _ListConsumosState();
}

class _ListConsumosState extends State<ListConsumos> {
  double valor = 0;

  //Valores de los desplegables Cantidad y Hs Uso
  var cantidad = <int>[];
  int ValorCantidad = 1;

  var cantidadHoras = <int>[];
  int ValorHs = 1;

  //Mapa para guardar la selección
  final seleccion = Map<String, double>;

  @override
  void initState() {
    super.initState();
    inicializa();
  }

  //Funcion que inicializa los desplegables de Cantidad y Hs de Uso
  inicializa() {
    for (int i = 1; i < 13; i++) {
      cantidad.add(i);
    }
    for (int i = 1; i < 25; i++) {
      cantidadHoras.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    dimensionamientoProvider.inicioSeleccion();
    dimensionamientoProvider.inicializacion();

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          ubicacion(context),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: 70),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: listadoConsumos(context))),
        ],
      ),
    );
  }

//Contenedor con Listado de ubicaciones
  Container ubicacion(BuildContext context) {
    return Container(
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
              style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
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
              style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
            ),
            Icon(Icons.batch_prediction_rounded)
          ],
        ),
        SizedBox(
          height: 25,
        ),
      ],
    ));
  }

//Contenedor con el ListView de los consumos
  ListView listadoConsumos(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    var contadoritem = dimensionamientoProvider.consumosJson.length;

    return ListView.builder(
      padding: EdgeInsets.only(left: 10, right: 10),
      itemExtent: 100.0,
      itemCount: contadoritem,
      itemBuilder: (context, index) {
        return Column(children: [
          Divider(
            endIndent: 10,
            indent: 10,
            thickness: 2,
            color: Colors.white,
          ),
          CheckboxListTile(
              //enableFeedback: true,
              dense: true,
              activeColor: Color.fromARGB(255, 6, 0, 0),
              tileColor: Color.fromARGB(255, 255, 255, 255),
              selectedTileColor: Colors.white,
              side: BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 255, 255, 255)),
              contentPadding: EdgeInsets.all(5),

              //NOMBRE DEL CONSUMO
              title: Text(
                '${dimensionamientoProvider.consumosJson.keys.elementAt(index)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),

              //POTENCIA CONSUMIDA
              subtitle: Text(
                '(${dimensionamientoProvider.consumosJson.values.elementAt(index)} W)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              value: dimensionamientoProvider.seleccion[index],
              selected: dimensionamientoProvider.seleccion[index],
              onChanged: (bool? value) {
                setState(() {
                  // RESUELTO SUMA Y RESTA CONSUMO
                  dimensionamientoProvider.seleccion[index] = value!;

                  //Me guardo el valor ->
                  valor = dimensionamientoProvider.consumosJson.values
                      .elementAt(index)
                      .toDouble();

                  ventanaEmergente(index, context);
                });

                if (dimensionamientoProvider.indicesSeleccionados
                    .contains(index)) {
                  dimensionamientoProvider.indicesSeleccionados.remove(index);
                  dimensionamientoProvider.Resta(valor);

                  //     .consumosJson.keys
                  //     .elementAt(index));
                  // ('ESTABA SELECCIONADO Y LO RESTA');

                  //Manejo con BD
                  // SQLHelper.deleteConsumo(dimensionamientoProvider

                } else {
                  dimensionamientoProvider.indicesSeleccionados
                      .add(index); // select
                  dimensionamientoProvider.Suma(valor); //Suma en el Total
                  SQLHelper.createConsumo(
                      dimensionamientoProvider.consumosJson.keys
                          .elementAt(index),
                      dimensionamientoProvider.consumosJson.values
                          .elementAt(index));
                  // ('NO ESTABA SELECCIONADO Y LO SUMA');
                }
              }),
        ]);
      },
    );
  }

//Desplegable de cantidades de consumos
  DropdownButton<int> desplegableCantidad(int index, context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return DropdownButton(
      underline: SizedBox(),
      style: const TextStyle(fontSize: 18, color: Colors.white),
      value: ValorCantidad,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      items: cantidad.map<DropdownMenuItem<int>>((value) {
        return DropdownMenuItem<int>(
          value: value,
          child: SizedBox(
              child: Text(
            value.toString(),
            textAlign: TextAlign.center,
          )),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          //potencia * cantidad
          dimensionamientoProvider.parcial = dimensionamientoProvider
                  .consumosJson.values
                  .elementAt(index)
                  .toDouble() *
              newValue!.toDouble();
          print(
              "POTENCIA POR CANTIDAD:" + '${dimensionamientoProvider.parcial}');

          //Me guardo la cantidad en la posición Index del Array
          dimensionamientoProvider.cantidad[index] = newValue!;
          ValorCantidad = newValue;

          dimensionamientoProvider.EnergiaDiaria += ValorCantidad *
              dimensionamientoProvider.consumosJson.values.elementAt(index) *
              ValorHs;
        });
      },
    );
  }

//Desplegable de horas de uso
  DropdownButton<int> desplegableHoras(int index, BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return DropdownButton(
      underline: SizedBox(),
      style: const TextStyle(fontSize: 18, color: Colors.white),
      value: ValorHs,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      items: cantidadHoras.map<DropdownMenuItem<int>>((value) {
        return DropdownMenuItem<int>(
          value: value,
          child: SizedBox(
              child: Text(
            value.toString(),
            textAlign: TextAlign.center,
          )),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          //Guardo valor en horas
          dimensionamientoProvider.horas = newValue!.toDouble();

          dimensionamientoProvider.cantidadHoras[index] = newValue!;
          ValorHs = newValue;
        });
      },
    );
  }

//Emergente con los desplegables
  Future ventanaEmergente(int index, BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: false);
    // Muestra en pantalla Consumo -> Cantidad -> Hs Uso
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${dimensionamientoProvider.consumosJson.keys.elementAt(index)}',
            style: TextStyle(fontSize: 28, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            height: 160,
            child: Column(
              children: <Widget>[
                Text('Cantidad'),
                SizedBox(
                  height: 10,
                ),
                desplegableCantidad(index, context),
                SizedBox(
                  height: 20,
                ),
                Text('Hs Uso'),
                SizedBox(
                  height: 10,
                ),
                desplegableHoras(index, context)
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              height: 50,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300),
              child: IconButton(
                  icon: Row(children: [
                    Text(
                      'Continuar',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white)
                  ]),
                  onPressed: () {
                    Navigator.of(context).pop();

                    //contador energía
                    dimensionamientoProvider.sumaEnergia =
                        dimensionamientoProvider.sumaEnergia +
                            (dimensionamientoProvider.parcial *
                                dimensionamientoProvider.horas);

                    //Inicializo las variables
                    dimensionamientoProvider.parcial = 0;
                    dimensionamientoProvider.horas = 0;
                  }),
            )
          ],
        );
      },
    );
  }
}
