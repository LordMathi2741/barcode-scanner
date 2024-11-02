import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/scan_model.dart';

class DbProvider{

  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

 Future<Database> get database async {
     if(_database == null) {
        _database = await initDb();
      }
      return _database!;
    }

  Future<Database> initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'scansdb.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE scans("
              "id INTEGER PRIMARY KEY, type TEXT, value TEXT)");
        }
    );

  }

  Future<int> insertScan(ScanModel newScanModel ) async {
     final db = await database;
     final res = await db.insert("scans", newScanModel.toJson());
     return res;
    }

    Future<ScanModel?> getScanById(int id) async{
      final db = await database;
      final scan = await db.query("scans", where: 'id = ?', whereArgs: [id]);
      return scan.isNotEmpty ? ScanModel.fromJson(scan.first) : null;
    }
    
    Future<List<ScanModel>?> getAllScans() async {
      final db = await database;
      final scans = await db.query("scans");
      return scans.isNotEmpty ? scans.map((scan) => ScanModel.fromJson(scan)).toList() : null;
    }

  Future<List<ScanModel>?> getScansByType(String type) async{
    final db = await database;
    final scans = await db.query("scans", where: 'type = ?', whereArgs: [type]);
    return scans.isNotEmpty ? scans.map((scan) => ScanModel.fromJson(scan)).toList() : null;
  }

  Future<int> updateScan(ScanModel newScan) async{
    final db = await database;
    final scan = await db.update("scans", newScan.toJson(), where: "id = ?", whereArgs: [newScan.id]);
    return scan;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete("scans", where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM scans");
    return res;
  }

  }
