import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/red_page.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';
import '../models/class_app.dart';
import 'grupo_page.dart';

class InicioInstaladorPage extends StatefulWidget {
  const InicioInstaladorPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageInstaladorState createState() => _InicioPageInstaladorState();
}

class _InicioPageInstaladorState extends State<InicioInstaladorPage> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    return Scaffold(
        body: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
            ),
            Text('Para avanzar con el dimensionamiento..'),
            SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                checkRed(),
                SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'assets/images/fact.jpeg',
                  height: 100,
                ),
                SizedBox(
                  height: 25,
                ),
                checkGrupo(),
                Image.asset(
                  'assets/images/logo_grupo_electrogeno_t.png',
                  height: 100,
                ),
              ],
            ),
          ],
        )),
        appBar: dimAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (dimensionamientoProvider.Grupo &&
                dimensionamientoProvider.Red) {
              await _showError(context);
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
              await _showError(context);
            }
          },
          label: const Text(
            'Continuar',
          ),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
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
                        "La energ??a diaria consumida depende de la potencia (W) y tiempo de uso (kWh)",
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
        }),
  );
}

Future _showError(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Row(
        children: const <Widget>[
          Expanded(
            child: Text(
              "??Seleccione correctamente!",
              style: TextStyle(
                fontSize: 14,
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
}
