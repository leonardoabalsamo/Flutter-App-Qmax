import 'package:flutter/material.dart';
import 'package:qmax_inst/src/models/bateria_model.dart';
import 'package:qmax_inst/src/models/inversor_model.dart';

class ConfigPage extends StatefulWidget {
  final Inversor inversor;
  final Bateria bateria;
  final num cantidad;
  final String instalacion;
  final String red;
  final String solucion;

  const ConfigPage(
      {Key? key,
      required this.inversor,
      required this.bateria,
      required this.cantidad,
      required this.instalacion,
      required this.red,
      required this.solucion})
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
            const Text('Configuración Recomendada: ',
                style: TextStyle(color: Colors.white)),
            verificaConfiguracion(context),
            Text(widget.instalacion,
                style: const TextStyle(color: Colors.white)),
            Text(widget.solucion, style: const TextStyle(color: Colors.white)),
            Text(widget.red, style: const TextStyle(color: Colors.white)),
            Text(widget.inversor.modeloInversor,
                style: const TextStyle(color: Colors.white)),
            Text(widget.bateria.modeloBateria,
                style: const TextStyle(color: Colors.white)),
            Text(widget.cantidad.toString()),
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
          onPressed: () {},
          backgroundColor: Colors.green.shade600,
          child: const Icon(Icons.beenhere),
        ));
  }

  Widget verificaConfiguracion(context) {
    Widget retorno;

    if (widget.instalacion == "ESTACIONARIA") {
      if (widget.red == "SI") {
        if (widget.solucion == "BACKUP") {
          retorno = const Text(
              "MODO: INVERSOR-CARGADOR // PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(color: Colors.white));
        } else {
          retorno = const Text(
              "MODO: AUTOCONSUMO // PERFIL DE ENTRADA: ESTRICTA // TENSION DE BATERIA DE CIERRE DERIVACION:  // TENSION DE BATERIA PARA APERTURA DE DERIVACION: ",
              style: TextStyle(color: Colors.white));
        }
      } else {
        retorno = const Text(
            "MODO: INVERSOR-CARGADOR // PERFIL DE ENTRADA: TOLERANTE  ",
            style: TextStyle(color: Colors.white));
      }
    } else {
      retorno = const Text("MODO: SOLO CARGADOR",
          style: TextStyle(color: Colors.white));
    }
    return retorno;
  }
}
