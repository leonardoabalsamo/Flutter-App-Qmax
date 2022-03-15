import 'package:flutter/material.dart';
import 'package:qmax_inst/src/pages/inicio_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  builder: (BuildContext context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(10.0),
                    content: Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text(
                            "La nueva App brinda una forma ágil y rápida para configurar los Inversores SP Digital según la solución planteada ",
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
        title:
            const Text('INVERSORES LINEA SPD', style: TextStyle(fontSize: 12)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InicioPage()),
          );
        },
        label: const Text(
          'Ingresar',
        ),
        icon: const Icon(Icons.arrow_right),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Center homePageColumn() {
    return Center(
        child: Column(children: [
      const SizedBox(height: 100),
      Expanded(
        child: Image.asset('assets/images/inv.png'),
      ),
      Expanded(
        child: Image.asset('assets/images/monitor.png'),
      ),
      const SizedBox(
        height: 5,
      ),
      const Expanded(
        child: Text(
          "¡Bienvenido!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28),
          textScaleFactor: 1,
        ),
      ),
    ]));
  }
}
