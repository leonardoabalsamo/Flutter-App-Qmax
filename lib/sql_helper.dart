import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async';

class SQLHelper {
  static Future<void> createTableConsumo(sql.Database database) async {
    await database.execute("""
      CREATE TABLE consumos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        descripcion TEXT,
        potencia INTEGER,
      )""");
  }
  /*

    await database.execute("""
      CREATE TABLE inversores(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        modelo TEXT,        
        potencia INTEGER,
        tensionNominal NUMERIC,
      )""");

    await database.execute("""
      CREATE TABLE ubicaciones(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        descripcion TEXT,        
        horas_solares REAL,
      )""");
  */

  static Future<void> createTableBateria(sql.Database database) async {
    await database.execute("""
      CREATE TABLE baterias(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        tipo TEXT,
        modelo TEXT,        
        fondo REAL,
        flote REAL,
        capacidad INTEGER,
        tensionNominal NUMERIC,
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'qmax_database.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTableConsumo(database);
        //await createTableBateria(database);
      },
    );
  }

  // crear items
  static Future<int> createConsumo(String descripcion, int? potencia) async {
    final db = await SQLHelper.db();

    final data = {'descripcion': descripcion, 'potencia': potencia};
    final id = await db.insert('consumos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createBateria(String tipo, String modelo, double fondo,
      double flote, int capacidad, num tensionNominal) async {
    final db = await SQLHelper.db();

    final data = {
      'tipo': tipo,
      'modelo': modelo,
      'fondo': fondo,
      'flote': flote,
      'capacidad': capacidad,
      'tensionNominal': tensionNominal
    };
    final id = await db.insert('baterias', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createInversor(
      String modelo, int potencia, num tensionNominal) async {
    final db = await SQLHelper.db();

    final data = {
      'modelo': modelo,
      'potencia': potencia,
      'tensionNominal': tensionNominal
    };
    final id = await db.insert('inversores', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createUbicacion(
      String descripcion, double horas_solares) async {
    final db = await SQLHelper.db();

    final data = {'descripcion': descripcion, 'horas_solares': horas_solares};
    final id = await db.insert('ubicaciones', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Leer todos los items
  static Future<List<Map<String, dynamic>>> getConsumos() async {
    final db = await SQLHelper.db();
    return db.query('consumos', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getBaterias() async {
    final db = await SQLHelper.db();
    return db.query('baterias', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getInversores() async {
    final db = await SQLHelper.db();
    return db.query('inversores', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getUbicaciones() async {
    final db = await SQLHelper.db();
    return db.query('ubicaciones', orderBy: "id");
  }

  // leer un item por id
  static Future<List<Map<String, dynamic>>> getConsumo(int id) async {
    final db = await SQLHelper.db();
    return db.query('consumos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getBateria(int id) async {
    final db = await SQLHelper.db();
    return db.query('baterias', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getInversor(int id) async {
    final db = await SQLHelper.db();
    return db.query('inversores', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUbicacion(int id) async {
    final db = await SQLHelper.db();
    return db.query('ubicaciones', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Actualizar un consumo por id
  static Future<int> updateConsumo(
      int id, String descripcion, int? potencia) async {
    final db = await SQLHelper.db();

    final data = {
      'descripcion': descripcion,
      'potencia': potencia,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('consumos', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateBateria(int id, String tipo, String modelo,
      double fondo, double flote, int capacidad, num tensionNominal) async {
    final db = await SQLHelper.db();

    final data = {
      'tipo': tipo,
      'modelo': modelo,
      'fondo': fondo,
      'flote': flote,
      'capacidad': capacidad,
      'tensionNominal': tensionNominal,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('baterias', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateInversor(
      int id, String modelo, int potencia, num tensionNominal) async {
    final db = await SQLHelper.db();

    final data = {
      'modelo': modelo,
      'potencia': potencia,
      'tensionNominal': tensionNominal,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('inversores', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateUbicacion(
      int id, String descripcion, double horas_solares) async {
    final db = await SQLHelper.db();

    final data = {
      'descripcion': descripcion,
      'horas_solares': horas_solares,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('ubicaciones', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Borrar por id
  static Future<void> deleteConsumo(String descripcion) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("consumos",
          where: "descripcion = ?", whereArgs: [descripcion]);
    } catch (err) {
      debugPrint("Algo salio mal al intentar borrar el consumo: $err");
    }
  }

  static Future<void> deleteConsumos() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("consumos");
    } catch (err) {
      debugPrint("Algo salio mal al intentar borrar el consumo: $err");
    }
  }

  static Future<void> deleteBateria(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("baterias", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo salio mal al intentar borrar la bateria: $err");
    }
  }

  static Future<void> deleteInversor(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("inversores", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo salio mal al intentar borrar el inversor: $err");
    }
  }

  static Future<void> deleteUbicacion(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("ubicaciones", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo salio mal al intentar borrar la ubicacion: $err");
    }
  }
}
