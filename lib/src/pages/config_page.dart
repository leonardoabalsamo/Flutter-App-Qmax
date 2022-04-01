// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../providers/seleccion_provider.dart';

import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';
import 'inicio_page.dart';

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
    return Scaffold(
        body: vista(context),
        appBar: AppBar(
          title: const Text(
            'CONFIGURACIÓN RECOMENDADA',
            style: TextStyle(fontSize: 12),
          ),
        ),
        floatingActionButton: floatContainer());
  }

  Container floatContainer() {
    return Container(
      padding: EdgeInsets.zero,
      child: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Seleccion.cantidad = 0;
          Seleccion.red = "";
          Seleccion.tipoInstalacion = "";
          Seleccion.tipoSolucion = "";
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InicioPage()));
        },
      ),
    );
  }

  Center vista(context) {
    var seleccionProvider = Provider.of<SeleccionProvider>(context);

    return Center(
      child: ListView(children: [
        const SizedBox(
          height: 2,
        ),
        Column(
          children: [
            Image.asset(
              "assets/images/inv.png",
              height: 120.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Manual'),
                  onPressed: () async {
                    var file = await getAssetByName(
                        "manuales/manual_inversor_spd.pdf");
                    OpenFile.open(file.path, type: "application/pdf");
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text('Descargar Configuración'),
                  onPressed: () async {
                    //writeJson(data);
                  },
                ),
              ],
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
    );
  }
}

void writeJson(Map<String, dynamic> data) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/configTxt.json');
  // print(directory.path.toString());
  // print(json.encode(data));
  await file.writeAsString(json.encode(data));
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
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());
        retorno.add(const Text("PERFIL DE ENTRADA:   ESTRICTA ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());
        retorno.add(Text(
            'CAPACIDAD DEL BANCO:   ' + finalbanco.toString() + ' Ah',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        /////////      BACKUP      /////////
        ////////////////////////////////////

        Map<String, dynamic> data = {
          '1': 2, // Permiso de escritura
          '2': 0, // Modo de funcionamiento
          '167': 0, // Perfil de entrada
          '10': finalbanco, // capacidad banco
          '13': bat
              .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
          '180': pasored, // V bat paso a red ||||||||
          '182': retornored, // V bat retorno de red |||||
        };

        writeJson(data);

        ///////////////////////////////////////////////////////

      } else {
        retorno.add(const Text("MODO: AUTOCONSUMO ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text(
            "TENSION DE BATERIA DE CIERRE DERIVACION:  " +
                pasored.toString() +
                ' V',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text(
            "TENSION DE BATERIA PARA APERTURA DE DERIVACION:  " +
                retornored.toString() +
                ' V',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text(
            'CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 14,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        /////////      AUTOCONSUMO      /////////
        ////////////////////////////////////////

        Map<String, dynamic> data = {
          '1': 2, // Permiso de escritura
          '2': 2, // Modo de funcionamiento
          '167': 0, // Perfil de entrada
          '10': finalbanco.toString(), // capacidad banco
          '13': bat
              .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
          '180': pasored, // V bat paso a red ||||||||
          '182': retornored, // V bat retorno de red |||||
        };

        writeJson(data);

        ///////////////////////////////////////////////////////
      }
    } else {
      retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 14,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 14,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 14,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      /////////      INV_CARG      /////////
      ////////////////////////////////////////

      Map<String, dynamic> data = {
        '1': 2, // Permiso de escritura
        '2': 0, // Modo de funcionamiento
        '167': 1, // Perfil de entrada
        '10': finalbanco, // capacidad banco
        '13': bat
            .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
        '180': pasored, // V bat paso a red ||||||||
        '182': retornored, // V bat retorno de red |||||
      };

      writeJson(data);

      ///////////////////////////////////////////
    }
  }
  if (Seleccion.tipoInstalacion == "VEHICULOS") {
    retorno.add(const Text("MODO: SOLO CARGADOR ",
        style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));
    retorno.add(const Divider());

    retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
        style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));
    retorno.add(const Divider());

    retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
        style: const TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));
    retorno.add(const Divider());

    /////////      INV_CARG      /////////
    ////////////////////////////////////////

    Map<String, dynamic> data = {
      '1': 2, // Permiso de escritura
      '2': 1, // Modo de funcionamiento
      '167': 1, // Perfil de entrada
      '10': finalbanco, // capacidad banco
      '13': bat
          .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
      '180': pasored, // V bat paso a red ||||||||
      '182': retornored, // V bat retorno de red |||||
    };

    writeJson(data);

    // String jsonString = jsonEncode(data);
    // print(jsonString);

    ///////////////////////////////////////////
  }

  return retorno;
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
