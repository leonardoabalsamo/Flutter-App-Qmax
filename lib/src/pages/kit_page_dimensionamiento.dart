import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/sql_helper.dart';

import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

class KitPage extends StatefulWidget {
  const KitPage({
    Key? key,
  }) : super(key: key);

  @override
  _KitPage createState() => _KitPage();
}

class _KitPage extends State<KitPage> {
  List<Map<String, dynamic>> _consumos = [];
  List<Map<String, dynamic>> _inversores = [];
  List<Map<String, dynamic>> _baterias = [];

  bool _cargando = true;

  // This function is used to fetch all data from the database
  void _refreshConsumos() async {
    final data = await SQLHelper.getConsumos();
    setState(() {
      _consumos = data;
      _cargando = false;
    });
  }

  void _CargaInversores() async {
    final data = await SQLHelper.getInversores();
    setState(() {
      _inversores = data;
      _cargando = false;
    });
  }

  void _CargaBaterias() async {
    final data = await SQLHelper.getBaterias();
    setState(() {
      _baterias = data;
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshConsumos(); // Loading the diary when the app starts

    // for (var item in _consumos) {
    //   print('Descripcion: ' + '${item.values}');
    //   print('Cargando: ' + '${_cargando}');
    // }
  }

  void imprimirValores() {
    //_refreshConsumos();
    //_CargaBaterias();
    //_CargaInversores();
    print("¿CONSUMOS ESTA VACIO?");
    print(_consumos.isEmpty);
    //print(_baterias.isEmpty);
    //print(_inversores.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    var contadorItem = dimensionamientoProvider.texto.length;
    //Tiene datos muestra kits
    return Scaffold(
        // body: Center(
        //   child: ListView(
        //       padding: const EdgeInsets.all(20.0),
        //       scrollDirection: Axis.vertical,
        //       children: dimensionamientoProvider.texto),
        // ),

        body: _cargando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Card(
                elevation: 20.0,
                margin: EdgeInsets.only(bottom: 80),
                child: Column(children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: _consumos.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        ListTile(
                          title: Text(_consumos[index]['descripcion']),
                          subtitle:
                              Text(_consumos[index]['potencia'].toString()),
                        ),
                        Divider(),
                      ]);
                    },
                  )),
                ]),
              ),
        // : ListView.builder(
        //     itemCount: _consumos.length,
        //     itemBuilder: (context, index) => Card(
        //       color: Colors.orange[200],
        //       margin: const EdgeInsets.all(15),
        //       child: ListTile(
        //           title: Text(_consumos[index]['descripcion']),
        //           subtitle: Text(_consumos[index]['potencia']),
        //           trailing: SizedBox(
        //             width: 100,
        //             child: Row(
        //                 // children: [
        //                 //   IconButton(
        //                 //       icon: const Icon(Icons.edit),
        //                 //       onPressed: () =>
        //                 //           {} _showForm(_journals[index]['id']),
        //                 //       ),
        //                 //   IconButton(
        //                 //       icon: const Icon(Icons.delete),
        //                 //       onPressed: () => {}
        //                 //        _deleteItem(_journals[index]['id']),
        //                 //       ),
        //                 //],
        //                 ),
        //           )),
        //     ),
        //   ),
        appBar: dimAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: imprimirValores,
        ));
  }

  AppBar dimAppBar() {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return AppBar(
      title: const Text(
        'DIMENSIONAMIENTO KITPAGE',
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
                          "El kit recomendado es orientativo. Comunicarse para obtener una cotización final",
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
            dimensionamientoProvider.texto.clear();
            dimensionamientoProvider.UbicacionSeleccionada = '';
            dimensionamientoProvider.PotenciaPaneles = 0;
            dimensionamientoProvider.BancoBateria = 0;
            dimensionamientoProvider.totalEnergia = 0;
            dimensionamientoProvider.EnergiaDiaria = 0;
            dimensionamientoProvider.valorFactura = 0;

            /*Vaciamos la BD de consumos*/
            SQLHelper.deleteConsumos();
          }),
    );
  }
}
