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
        title: const Center(
          child: Text(
            'Inicio Qmax e-control SPD',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InicioPage()),
          );
        },
        label: const Text('Continuar',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        backgroundColor: Colors.blue.shade600,
        icon: const Icon(Icons.thumb_up),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Column homePageColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Divider(
        color: Colors.white,
        height: 20,
        indent: 20,
        endIndent: 20,
      ),
      Image.asset(
        "assets/images/inv.png",
        height: 250.0,
        width: 250.0,
      ),
      const Divider(
        color: Colors.white,
        height: 20,
        indent: 20,
        endIndent: 20,
      ),
      Image.asset(
        "assets/images/cargador.png",
        height: 250.0,
        width: 250.0,
      ),
      const Text(
        'El fin de esta aplicación es conocer que configuraciones se deben modificar para cada tipo de solución',
        style: TextStyle(color: Colors.white, fontSize: 20.0, wordSpacing: 3.0),
      ),
    ]);
  }
}
