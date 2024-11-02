import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  int _selectedMenuOpt = 0;
  int get selectedMenuOpt{
    return _selectedMenuOpt;
  }

  set selectedMenuOp(int index){
    _selectedMenuOpt = index;
    notifyListeners();
  }
}