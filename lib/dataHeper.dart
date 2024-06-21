import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:api_equipo/equipo.dart';

class DatabaseHelper {
  static Database? _database;
  static const String equiposTable = 'equipos';
  static const String colId = 'id';
  static const String colNombreEquipo = 'nombreEquipo';
  static const String colAnioFundacion = 'anioFundacion';
  static const String colFechaCampeonato = 'fechaCampeonato';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, 'equipos.db');

    // Abrir la base de datos
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $equiposTable('
      '$colId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$colNombreEquipo TEXT, '
      '$colAnioFundacion INTEGER, '
      '$colFechaCampeonato TEXT)',
    );
  }

  // Insertar equipo
  Future<int> insertEquipo(Equipo equipo) async {
    Database db = await this.database;
    return await db.insert(equiposTable, equipo.toMap());
  }

  // Actualizar equipo
  Future<int> updateEquipo(Equipo equipo) async {
    Database db = await this.database;
    return await db.update(
      equiposTable,
      equipo.toMap(),
      where: '$colId = ?',
      whereArgs: [equipo.id],
    );
  }

  // Eliminar equipo
  Future<int> deleteEquipo(int id) async {
    Database db = await this.database;
    return await db.delete(
      equiposTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  // Obtener lista de equipos
  Future<List<Equipo>> getEquiposList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps = await db.query(equiposTable);
    return List.generate(maps.length, (i) {
      return Equipo(
        id: maps[i][colId],
        nombreEquipo: maps[i][colNombreEquipo],
        anioFundacion: maps[i][colAnioFundacion],
        fechaCampeonato: maps[i][colFechaCampeonato],
      );
    });
  }
}
