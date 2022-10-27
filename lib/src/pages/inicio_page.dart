import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/models/class_app.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';

// import '../models/bateria_model.dart';
// import '../models/inversor_model.dart';
import 'medio_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
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
            cardInversores(context),
            cardBaterias(context),
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
                sP.ResetConfigInversor();
                sP.notificar(context);
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (sP.validacion()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MedioPage()),
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

  Widget cardInversores(context) {
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
                'MODELO DE INVERSOR',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.asset(
              'assets/images/inv.png',
              height: 120,
            ),
            ListaInversores(),
            SizedBox(
              height: 20,
            )
          ],
        )));
  }

  Widget cardBaterias(context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    if (sP.inversor == '') {
      return SizedBox();
    } else {
      return Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              ListaBaterias(),
              SizedBox(
                height: 20,
              )
            ],
          )));
    }
  }

  Widget cardCantidades(context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    if (sP.bateria == '') {
      return SizedBox();
    } else {
      return Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              ListaTensiones(),
              SizedBox(
                height: 20,
              )
            ],
          )));
    }
  }
}
