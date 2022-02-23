import 'package:flutter/material.dart';
import 'package:qmax_inst/src/models/estatica_class.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

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
                const Text('Configuración Recomendada: ',
                    style: TextStyle(color: Colors.white)),
                ListView(children: verificaConfiguracion()),
              ],
            ),
          ]),
        ),
        appBar: AppBar(
          title: const Text(
            'Configuración Recomendada',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade600,
        ),
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green.shade600,
          child: const Icon(Icons.beenhere),
        ));
  }

  List<Text> verificaConfiguracion() {
    var retorno = <Text>[];

    if (Estatica.tipoInstalacion == "ESTACIONARIA") {
      if (Estatica.red == "SI") {
        if (Estatica.tipoSolucion == "BACKUP") {
          retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(color: Colors.white)));
        } else {
          retorno.add(const Text("MODO: AUTOCONSUMO ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Text("TENSION DE BATERIA DE CIERRE DERIVACION:  ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Text(
              "TENSION DE BATERIA PARA APERTURA DE DERIVACION:",
              style: TextStyle(color: Colors.white)));
        }
      } else {
        retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
            style: TextStyle(color: Colors.white)));
        retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
            style: TextStyle(color: Colors.white)));
      }
    } else {
      retorno.add(const Text("MODO: SOLO CARGADOR ",
          style: TextStyle(color: Colors.white)));
      retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
          style: TextStyle(color: Colors.white)));
    }
    return retorno;
  }
}
