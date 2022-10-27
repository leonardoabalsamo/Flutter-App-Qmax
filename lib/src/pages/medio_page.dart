import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';
import '../models/class_app.dart';
import '../providers/seleccion_provider.dart';
import 'config_page.dart';

class MedioPage extends StatefulWidget {
  const MedioPage({
    Key? key,
  }) : super(key: key);

  @override
  _MedioPage createState() => _MedioPage();
}

class _MedioPage extends State<MedioPage> {
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
            cardInstalacion(context),
            cardRed(context),
            cardSolucion(context)
          ],
        )),
        appBar: appBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (validaInst()) {
              sP.regulador == true;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigPage()),
              );
            } else {
              showError(context);
            }
          },
          label: const Text('Obtener Configuración'),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Widget cardInstalacion(context) {
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
                'TIPO DE INSTALACIÓN',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.asset(
              "assets/images/instalacion.png",
              height: 120,
            ),
            ListaTipo(),
            SizedBox(
              height: 20,
            )
          ],
        )));
  }

  Widget cardRed(context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    if (sP.tipoInstalacion == '') {
      return SizedBox();
    }

    if (sP.tipoInstalacion == 'EMBARCACIONES/VEHICULOS') {
      return SizedBox(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'CONTINUAR VEHICULOS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )));
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
                  'RED ELECTRICA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Image.asset(
                "assets/images/inversor_iq.png",
                height: 120,
              ),
              ListaRed(),
              SizedBox(
                height: 20,
              )
            ],
          )));
    }
  }

  Widget cardSolucion(context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    if (sP.tipoInstalacion == 'EMBARCACIONES/VEHICULOS') {
      return SizedBox();
    }
    if (sP.tipoInstalacion == '') {
      return SizedBox();
    }
    if (sP.red == '') {
      return SizedBox();
    }

    if (sP.red == 'NO') {
      sP.tipoSolucion = '';
      return SizedBox(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'CONTINUAR GRUPO ELECTROGENO',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )));
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
                  'TIPO DE SOLUCIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListaSolucion(),
              SizedBox(
                height: 20,
              )
            ],
          )));
    }
  }

  bool validaInst() {
    bool check = true;

    var sP = Provider.of<SeleccionProvider>(context, listen: false);

    switch (sP.tipoInstalacion) {
      case 'ESTACIONARIA':
        switch (sP.red) {
          case 'SI':
            switch (sP.tipoSolucion) {
              case 'BACKUP':
                return check;
              case 'AUTOCONSUMO':
                return check;
              default:
                check = false;
                return check;
            }
          case 'NO':
            return check;
          default:
            check = false;
            return check;
        }
      case 'EMBARCACIONES/VEHICULOS':
        return check;
      default:
        check = false;
        return check;
    }
  }

  AppBar appBar(context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return AppBar(
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
            sP.ResetConfigInversor();
            Navigator.of(context).pop();
          }),
    );
  }
}
