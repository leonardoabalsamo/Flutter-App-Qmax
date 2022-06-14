import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    bool check = false;
    return Scaffold(
        body:
            //   child: ListView(
            //     children: [
            //       ///////////////////////////////////////////
            //       ///                                     ///
            //       // VER ESTO QUE ROMPE LA APP            ///
            //       ///                                     ///
            //       ///////////////////////////////////////////

            ListView.builder(
                itemCount: dimensionamientoProvider.consumosJson.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text('${dimensionamientoProvider.consumosJson}'),
                    value: check,
                    onChanged: (newValue) {
                      setState(() {
                        check = newValue!;
                      });
                    },
                  );
                }),

        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           SizedBox(
        //             height: 25,
        //           ),
        //           ListaUbicaciones(),
        //           Image.asset(
        //             'assets/images/logo_grupo_electrogeno_t.png',
        //             height: 100,
        //           ),
        //           SizedBox(
        //             height: 25,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        //

        appBar: dimAppBar(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {},
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
