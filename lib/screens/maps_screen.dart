import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner2/providers/scan_list_provider.dart';

import '../utils/utils.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = context.watch<ScanListProvider>();
    return Scaffold(
      body: ListView.builder(
          itemCount: scanListProvider.scans.length,
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
              key: Key(scanListProvider.scans[index].id.toString()),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) async {
                final id = scanListProvider.scans[index].id;
                await scanListProvider.deleteScanById(id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Coordenadas ${scanListProvider.scans[index].value} eliminado")),
                );
              },
              child: ListTile(
                leading: const Icon(Icons.map, color: Colors.indigo),
                title: Text(scanListProvider.scans[index].value),
                subtitle: Text("ID: ${scanListProvider.scans[index].id.toString()}"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => launchToUrl(context,scanListProvider.scans[index]),
              ),
            );
          }
      ),
    );
  }
}
