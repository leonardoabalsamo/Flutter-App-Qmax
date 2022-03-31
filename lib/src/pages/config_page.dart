// ignore_for_file: unused_import

import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../providers/seleccion_provider.dart';

import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';
import 'inicio_page.dart';

//const String _url = 'https://www.qmax.com.ar/#!art/doc/255';

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
    var seleccionProvider = Provider.of<SeleccionProvider>(context);

    return Scaffold(
        body: Center(
          child: ListView(children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/inv.png",
                  height: 140.0,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text('Abrir PDF'),
                    onPressed: () async {
                      var file = await getAssetByName(
                          "manuales/manual_inversor_spd.pdf");
                      OpenFile.open(file.path, type: "application/pdf");
                    },
                  ),
                ),
                SizedBox(
                    height: 600,
                    child: ListView(
                        padding: const EdgeInsets.all(20.0),
                        scrollDirection: Axis.vertical,
                        children: _verificaConfiguracion(
                            seleccionProvider.getInversor(),
                            seleccionProvider.getBateria))),
              ],
            ),
          ]),
        ),
        appBar: AppBar(
          title: const Text(
            'CONFIGURACIÓN RECOMENDADA',
            style: TextStyle(fontSize: 12),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Seleccion.cantidad = 0;
            Seleccion.red = "";
            Seleccion.tipoInstalacion = "";
            Seleccion.tipoSolucion = "";
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InicioPage()));
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Regresar', style: TextStyle(fontSize: 20.0)),
        ));
  }

  List<Widget> _verificaConfiguracion(Inversor inv, Bateria bat) {
    var retorno = <Widget>[];
    int cant = Seleccion.cantidad;

    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

    num retornored;
    retornored = (bat.fondo * aux) - 0.3;

    num pasored;
    pasored = (bat.tensionNominalBateria * aux);

    if (Seleccion.tipoInstalacion == "ESTACIONARIA") {
      if (Seleccion.red == "SI") {
        if (Seleccion.tipoSolucion == "BACKUP") {
          retorno.add(const Text("MODO DE FUNCIONAMIENTO:   INV/CARG ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
          retorno.add(const Text("PERFIL DE ENTRADA:   ESTRICTA ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
          retorno.add(Text(
              'CAPACIDAD DEL BANCO:   ' + finalbanco.toString() + ' Ah',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          /////////          BACKUP
          ///////////////////////////////////////////////////////

          // Map<int, String> data = {
          //   2: '0', // modo
          //   167: '0', // perfil de entrada
          //   10: finalbanco.toString(), // capacidad banco
          //   13: 'PerfilBateria' // perfil bat
          // };

          // final String jsonString = jsonEncode(data);
          // print(jsonString);

          ///////////////////////////////////////////////////////

        } else {
          retorno.add(const Text("MODO: AUTOCONSUMO ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA DE CIERRE DERIVACION:  " +
                  pasored.toString() +
                  ' V',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA PARA APERTURA DE DERIVACION:  " +
                  retornored.toString() +
                  ' V',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              'CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 15,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
        }
      } else {
        retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 15,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 15,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 15,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());
      }
    }
    if (Seleccion.tipoInstalacion == "VEHICULOS") {
      retorno.add(const Text("MODO: SOLO CARGADOR ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 15,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 15,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 15,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());
    }

    return retorno;
  }
}

Future<File> getAssetByName(String sourceName) async {
  var sampleData = await rootBundle.load("assets/$sourceName");
  final path = await _localPath;
  var file = File('$path/manual_inversor_spd.pdf'); //File('$path/$sourceName');
  file = await file.writeAsBytes(sampleData.buffer.asUint8List());
  return file;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
