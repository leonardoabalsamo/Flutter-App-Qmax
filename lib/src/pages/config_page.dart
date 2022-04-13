// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../providers/seleccion_provider.dart';

import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import 'inicio_page.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigPage createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  late String _jsonString;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('Impresion Directorio: $directory');
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/qmax_config.txt');
  }

  void _writeJson(Map<String, dynamic> value) async {
    // Inicializo _filePath
    final _filePath = await _localFile;

    //_json ->_jsonString
    _jsonString = jsonEncode(value);

    //Escribimos el archivo
    _filePath.writeAsString(_jsonString, mode: FileMode.writeOnly, flush: true);

    //Codificamos a Uint8List
    Uint8List bytes = await _filePath.readAsBytes();
    //Save as..
    await FileSaver.instance.saveAs('qmax_config', bytes, 'txt', MimeType.TEXT);
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
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.zero,
      child: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          seleccionProvider.cantBat = '0';
          seleccionProvider.red = "";
          seleccionProvider.tipoInstalacion = "";
          seleccionProvider.tipoSolucion = "";
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InicioPage()));
        },
      ),
    );
  }

  Center vista(context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    return Center(
      child: ListView(
        children: [
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
                      //Cargo el mapa json
                      Map<String, dynamic> _json = await getJson(
                          seleccionProvider.getInversor(),
                          seleccionProvider.getBateria);
                      //Escribo el archivo
                      _writeJson(_json);
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
        ],
      ),
    );
  }

  List<Widget> _verificaConfiguracion(Inversor inv, Bateria bat) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: false);
    var retorno = <Widget>[];

    switch (seleccionProvider.tipoInstalacion) {
      case 'ESTACIONARIA':
        retorno = consultaRed(seleccionProvider.red, bat, inv);
        break;
      case 'VEHICULOS':
        retorno = cargaVeh(bat, inv);
        break;

      default:
        retorno = opcionDefault();
        break;
    }

    return retorno;
  }

  Future getJson(Inversor inv, Bateria bat) async {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: false);
    int cant = int.parse(seleccionProvider.cantBat);
    Map<String, dynamic> _json = {};

    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

    num retornored;
    retornored = (bat.fondo * aux) - 0.3;

    num pasored;
    pasored = (bat.tensionNominalBateria * aux);

    if (seleccionProvider.tipoInstalacion == "ESTACIONARIA") {
      if (seleccionProvider.red == "SI") {
        if (seleccionProvider.tipoSolucion == "BACKUP") {
          //backup
          _json = {
            '1': 2, // Permiso de escritura
            '2': 0, // Modo de funcionamiento
            '167': 0, // Perfil de entrada
            '10': finalbanco, // capacidad banco
            '13': bat
                .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
            '180': pasored, // V bat paso a red ||||||||
            '182': retornored, // V bat retorno de red |||||
          };
        } else {
          //interactivo
          _json = {
            '1': 2, // Permiso de escritura
            '2': 1, // Modo de funcionamiento
            '167': 1, // Perfil de entrada
            '10': finalbanco, // capacidad banco
            '13': bat
                .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
            '180': pasored, // V bat paso a red ||||||||
            '182': retornored, // V bat retorno de red |||||
          };
        }
      } else {
        //inv/cargador
        //no tiene red
        _json = {
          '1': 2, // Permiso de escritura
          '2': 0, // Modo de funcionamiento
          '167': 1, // Perfil de entrada
          '10': finalbanco, // capacidad banco
          '13': bat
              .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
          '180': pasored, // V bat paso a red ||||||||
          '182': retornored, // V bat retorno de red |||||
        };
      }
    } else {
      //Vehiculos
      _json = {
        '1': 2, // Permiso de escritura
        '2': 0, // Modo de funcionamiento
        '167': 1, // Perfil de entrada
        '10': finalbanco, // capacidad banco
        '13': bat
            .tipo, // PB-ACIDO: 0 - PB-CALCIO:1 - GEL:2 - AGM:3 - SELLADA1:4 - SELLADA2:5 - LITIO:6
        '180': pasored, // V bat paso a red ||||||||
        '182': retornored, // V bat retorno de red |||||
      };
    }

    return _json;
  }

  List<Widget> cargaVeh(Bateria bat, Inversor inv) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: false);
    var retorno = <Widget>[];
    int cant = int.parse(seleccionProvider.cantBat);
    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

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

    retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria,
        style: const TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));
    retorno.add(const Divider());
    retorno.add(Text('CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
        style: const TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontSize: 14,
            leadingDistribution: TextLeadingDistribution.proportional)));

    return retorno;
  }

  List<Widget> consultaRed(String s, Bateria bat, Inversor inv) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: false);
    var retorno = <Widget>[];

    int cant = int.parse(seleccionProvider.cantBat);
    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

    num retornored;
    retornored = (bat.fondo * aux) - 0.3;
    num pasored;
    pasored = (bat.tensionNominalBateria * aux);

    switch (seleccionProvider.red) {
      case 'SI':
        switch (seleccionProvider.tipoSolucion) {
          case 'BACKUP':
            retorno.add(const Text("MODO DE FUNCIONAMIENTO:   INV/CARG ",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());
            retorno.add(const Text("PERFIL DE ENTRADA:   ESTRICTA ",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());

            retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());
            retorno.add(Text(
                'CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());
            return retorno;

          case 'AUTOCONSUMO':
            retorno.add(const Text("MODO: AUTOCONSUMO ",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());

            retorno.add(Text(
                "TENSION DE BATERIA DE CIERRE DERIVACION:  " +
                    pasored.toString() +
                    ' V',
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());

            retorno.add(Text(
                "TENSION DE BATERIA PARA APERTURA DE DERIVACION:  " +
                    retornored.toString() +
                    ' V',
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());

            retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());

            retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());
            retorno.add(Text(
                'CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontSize: 14,
                    leadingDistribution:
                        TextLeadingDistribution.proportional)));
            retorno.add(const Divider());
            return retorno;
          default:
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: const EdgeInsets.all(10.0),
                content: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Text(
                        "Debe seleccionar al menos una opción. Reintente",
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
            retorno.add(Text('0'));
            return retorno;
        }
      case 'NO':
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

        retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria,
            style: const TextStyle(
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
        return retorno;
      default:
        retorno = opcionDefault();
    }
    return retorno;
  }

  List<Widget> opcionDefault() {
    List<Widget> retorno = [];
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        content: Row(
          children: const <Widget>[
            Expanded(
              child: Text(
                "Debe seleccionar al menos una opción. Reintente",
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
    retorno.add(Text('0'));
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
