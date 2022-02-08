import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:qmax_inst/src/models/bateria_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qmax_inst/src/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'appQmax_database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE baterias(id INTEGER PRIMARY KEY, tipo TEXT, modelo TEXT, fondo REAL, flote REAL,  capacidad INTEGER , tensionNominal INTEGER )',
      );
    },
    version: 1,
  );

  var b1 = Bateria(
    id: 0,
    tipo: "PbAcido",
    modelo: 'TROJAN T105',
    fondo: 7.41,
    flote: 6.75,
    capacidad: 225,
    tensionNominal: 6,
  );

  var b2 = Bateria(
    id: 1,
    tipo: "PbAcido",
    modelo: 'TROJAN T605',
    fondo: 7.41,
    flote: 6.75,
    capacidad: 225,
    tensionNominal: 6,
  );

  var b3 = Bateria(
    id: 2,
    tipo: "AGM",
    modelo: 'Vision 6FM200X',
    fondo: 14.7,
    flote: 13.6,
    capacidad: 200,
    tensionNominal: 12,
  );

  var b4 = Bateria(
    id: 3,
    tipo: "AGM",
    modelo: 'Vision 6FM100X',
    fondo: 14.7,
    flote: 13.6,
    capacidad: 100,
    tensionNominal: 12,
  );

  Future<void> insertBateria(Bateria bateria) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'appQmax_database',
      bateria.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  await insertBateria(b1);
  await insertBateria(b2);
  await insertBateria(b3);
  await insertBateria(b4);

  Future<List<Bateria>> cargaBaterias() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('baterias');

    return List.generate(maps.length, (i) {
      return Bateria(
        id: maps[i]['id'],
        tipo: maps[i]['tipo'],
        modelo: maps[i]['modelo'],
        fondo: maps[i]['fondo'],
        flote: maps[i]['flote'],
        capacidad: maps[i]['capacidad'],
        tensionNominal: maps[i]['tensionNominal'],
      );
    });
  }

  cargaBaterias();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Integradores QMAX',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}
