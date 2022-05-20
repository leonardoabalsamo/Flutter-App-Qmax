import 'package:flutter/material.dart';
import 'package:qmax_inst/src/pages/home_page.dart';

import 'inicio_page_instalador.dart';

class onePage extends StatefulWidget {
  const onePage({Key? key}) : super(key: key);

  @override
  _onePage createState() => _onePage();
}

class _onePage extends State<onePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homePageColumn(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => FittedBox(
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(10.0),
                      content: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "La nueva App brinda una forma ágil y rápida de dimensionar sistemas",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            child: const Text('Aceptar'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.help))
        ],
        title: const Text('APLICACION INSTALADORES',
            style: TextStyle(fontSize: 12)),
        centerTitle: true,
      ),
    );
  }

  Center homePageColumn() {
    return Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(
        "¡Bienvenido!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 38),
        textScaleFactor: 1,
      ),
      Text(
        "Seleccione la Opción",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
        textScaleFactor: 1,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(30)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Image.asset(
          'assets/images/logogris.png',
          height: 100,
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(10),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InicioInstaladorPage()));
        },
        child: Image.asset(
          'assets/images/inst.png',
          height: 120,
          width: 120,
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]));
  }
}
