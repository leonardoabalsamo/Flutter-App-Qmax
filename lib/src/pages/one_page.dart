import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qmax_inst/src/pages/home_page.dart';
//import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

import '../widgets/menu_lateral.dart';
import 'inicio_page_instalador.dart';

class onePage extends StatefulWidget {
  const onePage({Key? key}) : super(key: key);

  @override
  _onePage createState() => _onePage();
}

class _onePage extends State<onePage> {
  @override
  Widget build(BuildContext context) {
    //oculta barra inferior y superior
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return principal(context);
  }

  Center homePageColumn() {
    return Center(
        child: Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "¡Bienvenido!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60),
          textScaleFactor: 1,
        ),
        SizedBox(
          height: 15,
        ),
        Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Image.asset(
                        'assets/images/logogris.png',
                        scale: 2.2,
                      ),
                    )),
                Text(
                  'CONFIGURACIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            )),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InicioInstaladorPage()));
                    },
                    child: Icon(
                      Icons.build_circle_outlined,
                      size: 170,
                    ),
                  )),
              Text(
                'DIMENSIONAMIENTO',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ]),
    ));
  }

  Widget principal(BuildContext context) {
    return Scaffold(
      body: homePageColumn(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(20.0),
                    content: Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text(
                            "La Aplicación brinda opciones de configuración y/o dimensionamiento de sistemas",
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
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.help))
        ],
        title: const Text('APLICACION INTEGRADORES',
            style: TextStyle(fontSize: 12)),
        centerTitle: true,
      ),
      drawer: menuLateral(),
    );
  }
}
