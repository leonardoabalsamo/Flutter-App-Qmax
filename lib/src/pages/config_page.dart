import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  final String inversor = "";
  final String bateria = "";
  final String cantidad = "";
  final String instalacion = "";
  final String red = "";
  final String solucion = "";

  const ConfigPage(
      {Key? key, inversor, bateria, cantidad, instalacion, red, solucion})
      : super(key: key);

  @override
  _ConfigPage createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(children: [
            Container(
              padding: const EdgeInsets.all(26.0),
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/bateria.png",
                  height: 250.0,
                  width: 250.0,
                ),
              ],
            ),
            Text(widget.inversor, style: const TextStyle(color: Colors.white)),
            Text(widget.bateria, style: const TextStyle(color: Colors.white)),
            Text(widget.cantidad),
            const Text(
              'HOLA MUNDO',
              style: TextStyle(color: Colors.white),
            )
          ]),
        ),
        appBar: AppBar(
          title: const Text(
            'Configuración Inversor Qmax e-control SPD',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[700],
        ),
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConfigPage()),
            );
          },
          backgroundColor: Colors.green.shade600,
          child: const Icon(Icons.beenhere),
        ));
  }
}
