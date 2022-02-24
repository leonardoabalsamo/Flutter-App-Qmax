import 'dart:io';
import 'package:path/path.dart';
import 'package:qmax_inst/src/models/bateria_model.dart';
import 'package:qmax_inst/src/models/inversor_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database = _database;
  static final DBProvider db = DBProvider();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    //_log.info('Base de datos inicializada');
    return _database;
  }

  Future<Database> initDB() async {
    //Patch de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'instaladores_db.db');
    //_log.info('Path: $path');

    /// Crear base de datos
    return await openDatabase(
      path,
      version: 12,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int newVersion) async {
    //_log.info('Creando base de datos');
    await db.execute('''
        CREATE TABLE inversores(
          id INTEGER PRIMARY KEY,
          modelo TEXT,
          nominal INTEGER,
          potencia INTEGER
        );
      ''');
    await db.execute('''
        CREATE TABLE baterias(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          modelo TEXT,
          fondo REAL,
          flote REAL,
          capacidad INTEGER,
          nominal INTEGER,
        );
      ''');
  }

  Future<int> insertBateria(Bateria bat) async {
    final id = bat.id;
    final tipo = bat.tipo;
    final modelo = bat.modeloBateria;
    final fondo = bat.fondo;
    final flote = bat.flote;
    final capacidad = bat.capacidadBateria;
    final nominal = bat.tensionNominalBateria;

    //opbtener la base de datos
    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO inversores (id, tipo , modelo , fondo , flote , capacidad , nominal)
    VALUES( $id, '$tipo', '$modelo', '$fondo' , '$flote' , '$capacidad' , '$nominal')
    ''');
    return res;
  }

  Future insertInversor(Inversor inv) async {
    final id = inv.id;
    final modelo = inv.modeloInversor;
    final nominal = inv.tensionNominalInversor;
    final potencia = inv.potenciaInversor;
    //opbtener la base de datos
    final db = await database;

    await db.rawInsert('''
      INSERT INTO inversores (id, modelo,nominal, potencia)
      VALUES( $id, '$modelo', '$nominal', '$potencia')
      ''');
  }

  Future consultaInversor() async {
    final List lista;

    //opbtener la base de datos
    final db = await database;

    lista = await db.rawQuery('''
      SELECT * FROM inversores 
      ''');

    return lista;
  }
}
