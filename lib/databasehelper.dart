import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'model/Details.dart';

class DatabaseHelper{
  Future<Database> database() async{
    return openDatabase(
      join(await getDatabasesPath(), 'details.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE details(id INTEGER KEY PRIMARY KEY, name TEXT, address TEXT)");
      },
      version: 1,
    );
  }

  Future<void> insertDetails(Details details) async{
    Database db = await database();
    await db.insert('details', details.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Details>> getDetails() async{
    final db = await database();
    var res = await db.query("details");
    List<Details> detailsMap = res.map((c) => Details.fromMap(c)).toList();
    return detailsMap;
  }

  deleteDetails(int id) async {
    final db = await database();
    return db.delete("details", where: "id = ?", whereArgs: [id]);
  }

}
