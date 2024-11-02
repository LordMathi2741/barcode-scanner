import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/scan_list_provider.dart';
import '../providers/ui_provider.dart';
import '../widgets/home_navigation_bar.dart';
import '../widgets/scan_button.dart';
import 'address_screen.dart';
import 'maps_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = context.watch<ScanListProvider>();
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child:  Text(
              "Historial",
              style: TextStyle(
                color: Colors.white
              ),
            )
        ),
        actions: [
          IconButton(
              onPressed: (){
                scanListProvider.deleteAllScans();
              },
              icon: const Icon(
                  Icons.delete_forever,
                color: Colors.white,
              )
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const HomeNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final scanListProvider = context.watch<ScanListProvider>();
    int currentIndex = uiProvider.selectedMenuOpt;
    switch(currentIndex){
      case 0:
        scanListProvider.getScansByType('geo');
        return const MapsScreen();
      case 1:
        scanListProvider.getScansByType('http');
        return const AddressScreen();
      default:
        return const MapsScreen();
    }
  }
}

