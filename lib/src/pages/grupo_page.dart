import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:path/path.dart';
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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return Scaffold(
        body: ListConsumos(),
        appBar: dimAppBar(context),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 101, 99, 99))),
                onPressed: () {
                  setState(() {
                    dP.Reset();
                    _resetConsumo(context);
                  });
                },
                child: Text('Reset')),
            FloatingActionButton.extended(
              onPressed: () async {
                if (dP.sumaEnergia == 0 || dP.Insolacion == 0) {
                  errorSeleccion(context);
                } else {
                  dP.kitAislado();
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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: false);
    dP.seleccion.clear();
    dP.sumaEnergia = 0; //contador de energía
    dP.potenciaTotal = 0; //contador potencia
    dP.cantidad.clear();
    dP.cantidadHoras.clear();
  }

  AppBar dimAppBar(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
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
                    children: <Widget>[
                      Container(
                          height: 110,
                          width: 200,
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("sumaEnergía: " + '${dP.sumaEnergia}'),
                              Text("Ubicación: " +
                                  '${dP.UbicacionSeleccionada}'),
                              Text("Insolación: " + '${dP.Insolacion}'),
                            ],
                          )),
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
            dP.Red = false;
            dP.Grupo = false;
            dP.Reset();
            dP.notificar(context);
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
  int ValorCantidad = 0;

  var cantidadHoras = <int>[];
  int ValorHs = 0;

  //flags

  var flagCantidad = false;
  var flagHs = false;

  //Mapa para guardar la selección
  final seleccion = Map<String, double>;

  @override
  void initState() {
    super.initState();
    inicializa();
  }

  //Funcion que inicializa los desplegables de Cantidad y Hs de Uso
  inicializa() {
    for (int i = 1; i < 12; i++) {
      cantidad.add(i);
    }
    for (int i = 1; i < 25; i++) {
      cantidadHoras.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    dP.inicioSeleccion(); // inicializa lista seleccion
    dP.inicializacion(); // inicializa DropDownButtons

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          ubicacion(context),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: 90),
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
          height: 10,
        ),
        ListaUbicaciones(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Selección de Panel',
          style: TextStyle(fontSize: 20),
        ),
        slideBarPanel(),
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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    var contadoritem = dP.consumosJson.length;

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
                '${dP.consumosJson.keys.elementAt(index)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),

              //POTENCIA CONSUMIDA
              subtitle: Text(
                '(${dP.consumosJson.values.elementAt(index)} W)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              value: dP.seleccion[index],
              selected: dP.seleccion[index],
              onChanged: (bool? value) {
                setState(() {
                  // RESUELTO SUMA Y RESTA CONSUMO
                  dP.seleccion[index] = value!;

                  //Me guardo el valor ->
                  valor = dP.consumosJson.values.elementAt(index).toDouble();

                  ventanaEmergente(index, context);
                });

                if (dP.indicesSeleccionados.contains(index)) {
                  dP.indicesSeleccionados.remove(index);
                  dP.Resta(valor);
                  // ('ESTABA SELECCIONADO Y LO RESTA');

                  //Manejo con BD
                  // SQLHelper.deleteConsumo(dP

                } else {
                  dP.indicesSeleccionados.add(index); // select
                  dP.Suma(valor); //Suma en el Total
                  SQLHelper.createConsumo(dP.consumosJson.keys.elementAt(index),
                      dP.consumosJson.values.elementAt(index));
                  // ('NO ESTABA SELECCIONADO Y LO SUMA');
                }
              }),
        ]);
      },
    );
  }

//Desplegable de cantidades de consumos
  DropdownButton<int> desplegableCantidad(int index, context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
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
          //Cantidad
          flagCantidad = true;
          ValorCantidad = newValue!;
          dP.cantidad[index] = ValorCantidad;
          dP.notificar(context);
        });
      },
    );
  }

//Desplegable de horas de uso
  DropdownButton<int> desplegableHoras(int index, BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
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
          flagHs = true;
          ValorHs = newValue!;
          dP.horas = ValorHs.toDouble();
          dP.cantidadHoras[index] = ValorHs;
          dP.notificar(context);
        });
      },
    );
  }

//Emergente con los desplegables
  Future ventanaEmergente(int index, BuildContext context) {
    // Muestra en pantalla Consumo -> Cantidad -> Hs Uso
    var dP = Provider.of<DimensionamientoProvider>(context, listen: false);
    ValorCantidad = 1;
    ValorHs = 1;

    //Si seleccionó, por lo menos es una unidad
    if (flagCantidad == false && flagHs == false) {
      seleccionInicial(index, context);
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${dP.consumosJson.keys.elementAt(index)}',
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
                    //Compenso sumaEnergia = 0;
                    dP.sumaEnergia -=
                        dP.consumosJson.values.elementAt(index).toDouble();

                    //contador energía
                    dP.sumaEnergia += (dP.cantidad[index] *
                            dP.cantidadHoras[index] *
                            dP.consumosJson.values.elementAt(index))
                        .toDouble();

                    dP.potenciaTotal += (dP.cantidad[index] *
                            dP.consumosJson.values.elementAt(index))
                        .toDouble();
                    ValorCantidad = 1;
                    ValorHs = 1;
                    flagCantidad = false;
                    flagHs = false;
                    dP.notificar(context);
                  }),
            )
          ],
        );
      },
    );
  }

  void seleccionInicial(int index, context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: false);
    dP.sumaEnergia += dP.consumosJson.values.elementAt(index).toDouble();
    ;
  }
}
