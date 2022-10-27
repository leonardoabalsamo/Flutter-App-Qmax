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
        body: Container(
          height: 650,
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(10),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListaConfigRed(context),
                      )
                    ],
                  ))),
        ),
        appBar: dimAppBar(context),
        floatingActionButton: btnFloat(context),
      );
    } else {
      //ListaGrupo
      return Scaffold(
        body: Container(
            height: 650,
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(10),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListaConfig(context),
                        )
                      ],
                    )))),
        appBar: dimAppBar(context),
        floatingActionButton: btnFloat(context),
      );
    }
  }

  AppBar dimAppBar(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return AppBar(
      title: const Text(
        ' KIT RECOMENDADO ',
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
            icon: const Icon(Icons.account_balance_wallet))
      ],
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            showReset(context);
          }),
    );
  }

  FloatingActionButton btnFloat(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.arrow_back_outlined),
        onPressed: () async {
          showReset(context);
        });
  }

  Container ListaConfig(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    //Tiene datos muestra la Lista Grupo
    return Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            (Text(
              'Generación de Energía',
              style: TextStyle(fontSize: 25),
            )),
            (SizedBox(
              height: 10,
            )),
            Text(
              'Panel Seleccionado: ' + dP.PanelSeleccionado.toString() + 'Wp',
            ),
            Divider(),
            Expanded(
              child:
                  ListView(scrollDirection: Axis.vertical, children: dP.texto),
            )
          ],
        ));
    //}
  }

  Container ListaConfigRed(context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (Text(
            'Generación de Energía',
            style: TextStyle(fontSize: 25),
          )),
          (SizedBox(
            height: 25,
          )),
          Text(
            'Panel Seleccionado: ' + dP.PanelSeleccionado.toString() + 'Wp',
          ),
          Divider(),
          Expanded(
            child: ListView(scrollDirection: Axis.vertical, children: dP.texto),
          )
        ],
      ),
    );
  }
}

Future showReset(context) {
  var dP = Provider.of<DimensionamientoProvider>(context, listen: false);
  return showDialog(
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
                MaterialPageRoute(builder: (context) => const onePage()),
              );
            }),
        TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    ),
  );
}
