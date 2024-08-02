// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_quote_api/utils/constants.dart';

class DBHelper {
  static Database? _database;

  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), Constants.dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Constants.favoriteTable} (
        ${Constants.idKey} TEXT PRIMARY KEY,
        ${Constants.contentKey} TEXT,
        ${Constants.translationKey} TEXT,
        ${Constants.imageKey} TEXT,
        ${Constants.authorKey} TEXT
      )
    ''');
  }

  Future<int> addToFavorites(Map<String, dynamic> row) async {
    Database db = await dbHelper.database;
    return await db.insert(Constants.favoriteTable, row);
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    Database db = await dbHelper.database;

    return await db.query(Constants.favoriteTable);
  }

  Future<int> deleteFavorite(String id) async {
    Database db = await dbHelper.database;
    return await db.delete(Constants.favoriteTable,
        where: '${Constants.idKey} = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
