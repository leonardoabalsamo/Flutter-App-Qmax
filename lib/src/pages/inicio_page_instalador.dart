import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/sql_helper.dart';
import 'package:qmax_inst/src/pages/red_page.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';
import 'package:sqflite/sqflite.dart';
import '../models/class_app.dart';
import '../widgets/menu_lateral.dart';
import 'grupo_page.dart';

class InicioInstaladorPage extends StatefulWidget {
  const InicioInstaladorPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageInstaladorState createState() => _InicioPageInstaladorState();
}

class _InicioPageInstaladorState extends State<InicioInstaladorPage> {
  void cargaDB() async {
/*
    SQLHelper.createConsumo('Heladera', 1000);
    SQLHelper.createConsumo('Freezer', 1200);
    SQLHelper.createConsumo('Lampara Led', 72);
    SQLHelper.createConsumo('Lavarropas', 500);
    SQLHelper.createConsumo('Cafetera', 188);
    SQLHelper.createConsumo('Bomba 3/4HP', 750);
    SQLHelper.createConsumo('Cargador Cel', 5);
    SQLHelper.createConsumo('Notebook', 80);
    SQLHelper.createConsumo('Televisor LED', 80);
    SQLHelper.createConsumo('Router Wifi', 100);
    SQLHelper.createConsumo('Ventilador Techo', 120);
    SQLHelper.createConsumo('Ventilador Pie', 160);
    SQLHelper.createConsumo('Aire Acondicionado 2200Fg', 3200);
*/
  }

  @override
  void initState() {
    super.initState();
    cargaDB();
  }

  @override
  Widget build(BuildContext context) {
    //SQLHelper.createBateria('PB-ACIDO', 'TROJAN T105', 7.25, 6.8, 225, 6);
    //SQLHelper.createInversor('QM-1212-SPD', 1200, 12);
    //SQLHelper.createUbicacion('Capital Federal', 5.1);

    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    return principal();
  }

  void verificaSeleccion() async {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: false);
    if (dimensionamientoProvider.Grupo && dimensionamientoProvider.Red) {
      await errorSeleccion(context);
      dimensionamientoProvider.Grupo = false;
      dimensionamientoProvider.Red = false;
      dimensionamientoProvider.notifyListeners();
    } else if (dimensionamientoProvider.Red) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RedPage()),
      );
    } else if (dimensionamientoProvider.Grupo) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GrupoPage()),
      );
    } else {
      await errorSeleccion(context);
    }
  }

  Scaffold principal() {
    return Scaffold(
        body: Container(
          margin: EdgeInsetsDirectional.only(top: 20, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.all(20),
                child: Text(
                  'Para avanzar con el dimensionamiento..',
                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/fact.jpeg',
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: 30),
                child: Column(
                  children: [
                    checkRed(),
                    SizedBox(
                      height: 50,
                    ),
                    checkGrupo(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/images/logo_grupo_electrogeno_t.png',
                ),
              ),
            ],
          ),
        ),
        appBar: dimAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            verificaSeleccion();
          },
          label: const Text(
            'Continuar',
          ),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
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
            SQLHelper.deleteConsumos();
          }),
    );
  }
}
