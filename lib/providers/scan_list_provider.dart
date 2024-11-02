import 'package:flutter/cupertino.dart';
import 'package:qrscanner2/providers/db_provider.dart';

import '../models/scan_model.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String selectedType = "http";

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DbProvider.db.insertScan(newScan);
    newScan.id = id;
    if (selectedType == newScan.type){
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  Future<void> getAllScans() async {
    final scansData = await DbProvider.db.getAllScans();
    scans = [...?scansData];
    notifyListeners();
  }

  Future<void> getScansByType(String type) async {
    final scansData = await DbProvider.db.getScansByType(type);
    scans = [...?scansData];
    notifyListeners();
  }

  Future<void> deleteAllScans() async {
    await DbProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  Future<void> deleteScanById(int id) async {
    await DbProvider.db.deleteScan(id);
    getScansByType(selectedType);
  }



}