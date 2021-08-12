import 'dart:developer' as dev;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// PlanObjectsTableManager provides instance of database and creates tables
class DbManager {
  ///Name of app database
  static const appDb = "test_db.db";

  ///Current version of app database
  static const appDbVersion = 1;

  static final DbManager instance = DbManager._();
  static Database? _database;

  DbManager._();

  ///Get instance of database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(appDb);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    dev.log("init DB", name: "INSPECT");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: appDbVersion,
      onCreate: _createTables,
    );
  }


  /// Create tables when the database is first created
  Future<void> _createTables(Database db, int version) async {
    dev.log("Create tables", name: "INSPECT");
    await db.execute('CREATE TABLE Table1 (id INTEGER PRIMARY KEY, firstname TEXT, surname TEXT, birthday TEXT)');
    await db.execute('CREATE TABLE Table2 (person_id INTEGER, id INTEGER, type TEXT, amount REAL)');
    dev.log("Insert data", name: "INSPECT");

    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Table1(id, firstname, surname, birthday) VALUES(1, "John", "Doe", "2000-01-01")');
      await txn.rawInsert(
          'INSERT INTO Table1(id, firstname, surname, birthday) VALUES(2, "Jane", "Doe", "2001-06-01")');
      await txn.rawInsert(
          'INSERT INTO Table1(id, firstname, surname, birthday) VALUES(3, "Vasya", "Pupkin", "1988-10-11")');

      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 1, "type 1", 50)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 2, "type 2", -100)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 3, "type 1", 75)');

      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 1, "type 1", 100)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 2, "type 2", -25)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 3, "type 3", -70)');

      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 1, "type 1", 100)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 2, "type 3", 10)');
      await txn.rawInsert(
          'INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 100, "type 4", -35)');

    });


//     await db.execute('''
// INSERT INTO Table1(id, firstname, surname, birthday) VALUES(1, "John", "Doe", "2000-01-01");
// INSERT INTO Table1(id, firstname, surname, birthday) VALUES(2, "Jane", "Doe", "2001-06-01");
// INSERT INTO Table1(id, firstname, surname, birthday) VALUES(3, "Vasya", "Pupkin", "1988-10-11");
//
// INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 1, "type 1", 50);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 2, "type 2", -100);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(1, 3, "type 1", 75);
//
// INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 1, "type 1", 100);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 2, "type 2", -25);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(2, 3, "type 3", -70);
//
// INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 1, "type 1", 100);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 2, "type 3", 10);
// INSERT INTO Table2(person_id, id, type, amount) VALUES(3, 100, "type 4", -35);
// ''');
  }
}
