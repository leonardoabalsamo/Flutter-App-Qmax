import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/one_page.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

//import '../models/class_app.dart';

class KitPage extends StatefulWidget {
  const KitPage({
    Key? key,
  }) : super(key: key);

  @override
  _KitPage createState() => _KitPage();
}

class _KitPage extends State<KitPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    //Tiene datos muestra kits
    if (dP.Red == true) {
      //ListaRed
      return Scaffold(
        body: ListaConfigRed(context),
        appBar: dimAppBar(context),
        floatingActionButton: btnFloat(context),
      );
    }
    //if (dP.Grupo == true) {
    else {
      //ListaGrupo
      return Scaffold(
        body: ListaConfig(context),
        appBar: dimAppBar(context),
        floatingActionButton: btnFloat(context),
      );
    }
    // else {
    //   //Default
    //   return Scaffold(
    //     body: Container(
    //       child: Text('ERROR DE SELECCION'),
    //     ),
    //     appBar: dimAppBar(context),
    //     floatingActionButton: btnFloat(context),
    //   );
    // }
  }

  AppBar dimAppBar(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return AppBar(
      title: const Text(
        'DIMENSIONAMIENTO KIT',
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
                          "El kit recomendado es meramente orientativo. Consulte a su instalador para obtener una cotización final",
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
            dP.ResetConf();
            Navigator.of(context).pop();
          }),
    );
  }

  FloatingActionButton btnFloat(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return FloatingActionButton(
        child: Icon(Icons.arrow_back_outlined),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              content: Row(
                children: const <Widget>[
                  Expanded(
                    child: Text(
                      "¿Desea Salir? Se borrarán los datos ingresados",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    child: const Text('Si'),
                    onPressed: () {
                      /*Vaciamos la BD de consumos*/
                      //SQLHelper.deleteConsumos();
                      dP.ResetConf();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const onePage()),
                      );
                    }),
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      dP.ResetConf();
                    })
              ],
            ),
          );
        });
  }

  Container ListaConfig(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    //Tiene datos muestra la Lista Grupo

    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            (Text(
              'Generación de Energía',
              style: TextStyle(fontSize: 30),
            )),
            (SizedBox(
              height: 10,
            )),
            Text(
              'Panel Seleccionado: ' + dP.PanelSeleccionado.toString() + 'Wp',
            ),
            Divider(),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(bottom: 70),
              child:
                  ListView(scrollDirection: Axis.vertical, children: dP.texto),
            ))
          ],
        ));
    //}
  }

  Container ListaConfigRed(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.all(20.0),
      //height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          (Text(
            'Generación de Energía',
            style: TextStyle(fontSize: 30),
          )),
          (SizedBox(
            height: 10,
          )),
          Text(
            'Panel Seleccionado: ' + dP.PanelSeleccionado.toString() + 'Wp',
          ),
          Divider(),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(bottom: 70),
            child: ListView(scrollDirection: Axis.vertical, children: dP.texto),
          ))
        ],
      ),
    );
  }
}
