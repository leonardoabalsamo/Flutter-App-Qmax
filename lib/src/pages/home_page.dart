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
        title: const Text('INVERSORES LINEA SPD'),
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
          'Continuar',
        ),
        icon: const Icon(Icons.arrow_right),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Column homePageColumn() {
    return Column(children: [
      const SizedBox(height: 100),
      Row(
        children: [
          Expanded(
            child: Image.asset('assets/images/inv.png'),
          ),
          Expanded(
            child: Image.asset('assets/images/monitor.png'),
          ),
        ],
      ),
      const SizedBox(
        height: 50,
      ),
      const Expanded(
        child: Text(
          "El fin de esta aplicación es conocer las configuraciones que se deben realizar para cada tipo de solución",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          textScaleFactor: 1,
        ),
      ),
    ]);
  }
}
