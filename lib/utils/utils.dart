import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';

Future<void> launchToUrl(BuildContext context,ScanModel scanModel) async {
  final url = scanModel.value;
  if (scanModel.type!.contains("http")){
    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }
    else{
      throw "Could not launch";
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scanModel);
  }
}