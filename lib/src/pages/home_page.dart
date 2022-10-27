import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/inicio_page.dart';
import 'package:qmax_inst/src/pages/inicio_page_regulador.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: homePageColumn(), appBar: dimAppBar(context));
  }

  Center homePageColumn() {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "SELECCIONE EL PRODUCTO",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
        textScaleFactor: 1,
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
                              builder: (context) => const InicioPage()));
                    },
                    child: Image.asset(
                      'assets/images/inv.png',
                      height: 180,
                    ),
                  )),
              Text(
                'INVERSOR SPD',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
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
                              builder: (context) =>
                                  const InicioPageRegulador()));
                    },
                    child: Image.asset(
                      'assets/images/mpptdisplay.png',
                      height: 150,
                    ),
                  )),
              Text(
                'MPPT',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              )
            ],
          )),
    ]));
  }

  AppBar dimAppBar(context) {
    return AppBar(
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
                            "La nueva App brinda una forma ágil y rápida para configurar los Equipos QMAX",
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
      title: const Text('INVERSORES SPD - REGULADORES',
          style: TextStyle(fontSize: 12, fontFamily: 'Roboto')),
      centerTitle: true,
    );
  }
}
