
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';


class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
        onTap: (int index) => uiProvider.selectedMenuOp = index,
        currentIndex: currentIndex,
        elevation: 0,
        items: const  [
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Mapa"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration),
              label: "Direcciones"
          ),
        ]
    );
  }
}


