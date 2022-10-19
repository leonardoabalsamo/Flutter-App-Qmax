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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SizedBox(
        height: 20,
      ),
      Text(
        "Seleccione el Producto",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            //fontStyle: FontStyle.italic,
            fontFamily: 'Roboto'),
        textScaleFactor: 1,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Inversor SPD",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
        textScaleFactor: 1,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(30)),
        onPressed: () {
          seleccionProvider.regulador = false;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InicioPage()));
        },
        child: Image.asset(
          'assets/images/inv.png',
          height: 150,
        ),
      ),
      Text(
        "Regulador MPPT",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
        textScaleFactor: 1,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(10),
        ),
        onPressed: () {
          seleccionProvider.regulador = true; //Flag Regulador
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InicioPageRegulador()));
        },
        child: Image.asset(
          'assets/images/mpptdisplay.png',
          height: 150,
        ),
      ),
      SizedBox(
        height: 50,
      )
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
      title: const Text('INVERSORES REGULADORES [ SPD ]',
          style: TextStyle(fontSize: 12, fontFamily: 'Roboto')),
      centerTitle: true,
    );
  }
}
