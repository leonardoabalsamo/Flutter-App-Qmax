import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/models/estatica_class.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../providers/bateria_provider.dart';
import '../providers/inversor_provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigPage createState() => _ConfigPage();
}


class _ConfigPage extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Inversor inv = Provider.of<InversorProvider>(context).inversorSeleccionado;
    Bateria bat = Provider.of<BateriaProvider>(context).getBateria;

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
                const Divider(),
                SizedBox(
                    height: 800,
                    child: ListView(
                        padding: const EdgeInsets.all(20.0),
                        scrollDirection: Axis.vertical,
                        children: _verificaConfiguracion(inv, bat)))
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
        floatingActionButton: FloatingActionButton(onPressed: () {}));
  }

  List<Widget> _verificaConfiguracion(Inversor inv, Bateria bat) {
    var retorno = <Widget>[];
    int cant = int.parse(Estatica.seleccionCantidad);

    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

    num retornored;
    retornored = bat.fondo * aux;

    num pasored;
    pasored = (bat.tensionNominalBateria * aux);

    if (Estatica.tipoInstalacion == "ESTACIONARIA") {
      if (Estatica.red == "SI") {
        if (Estatica.tipoSolucion == "BACKUP") {
          retorno.add(const Text("MODO DE FUNCIONAMIENTO:   INVERSOR-CARGADOR ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Divider());
          retorno.add(const Text("PERFIL DE ENTRADA:   ESTRICTA ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Divider());
          retorno.add(Text('CAPACIDAD DEL BANCO: ' + finalbanco.toString(),
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL:' + bat.modeloBateria,
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());
        } else {
          retorno.add(const Text("MODO: AUTOCONSUMO ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA DE CIERRE DERIVACION:  " + pasored.toString(),
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA PARA APERTURA DE DERIVACION:  " +
                  retornored.toString() +
                  retorno.toString(),
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(Text('CAPACIDAD DEL BANCO: ' + finalbanco.toString(),
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL:' + bat.modeloBateria,
              style: const TextStyle(color: Colors.white)));
          retorno.add(const Divider());
        }
      } else {
        retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
            style: TextStyle(color: Colors.white)));
        retorno.add(const Divider());

        retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
            style: TextStyle(color: Colors.white)));
        retorno.add(const Divider());

        retorno.add(Text('PERFIL:' + bat.modeloBateria,
            style: const TextStyle(color: Colors.white)));
        retorno.add(const Divider());
      }
    } else {
      retorno.add(const Text("MODO: SOLO CARGADOR ",
          style: TextStyle(color: Colors.white)));
      retorno.add(const Divider());

      retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
          style: TextStyle(color: Colors.white)));
      retorno.add(const Divider());

      retorno.add(Text('PERFIL:' + bat.modeloBateria,
          style: const TextStyle(color: Colors.white)));
      retorno.add(const Divider());
    }
    return retorno;
  }

  // Widget _config(BuildContext context, Future<List<Widget>> _lista) {
  //   Widget sb = SizedBox(
  //       height: 800,
  //       child: ListView(
  //           padding: const EdgeInsets.all(20.0),
  //           scrollDirection: Axis.vertical,
  //           children: [
              
  //           ]));
  //   return sb;
  // }
}
