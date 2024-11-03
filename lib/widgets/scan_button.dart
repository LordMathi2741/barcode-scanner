import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner2/providers/scan_list_provider.dart';
import 'package:qrscanner2/utils/utils.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = context.watch<ScanListProvider>();
    return FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        onPressed: () async {
          var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SimpleBarcodeScannerPage(),
              ));
          if (res != "-1"){
            final newScan = await scanListProvider.newScan(res);
            launchToUrl(context, newScan);
          }

        },
        child: const Icon(
            Icons.filter_center_focus
        ) ,
    );
  }
}
