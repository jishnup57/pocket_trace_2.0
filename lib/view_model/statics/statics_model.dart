import 'package:flutter/material.dart';

class Statics with ChangeNotifier{

  String choice = 'Income';
  
  choiceChipRebuild(String choice) {
    this.choice = choice;
   notifyListeners();
  }
}