


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions with ChangeNotifier{

Functions._internal();

  static Functions instance = Functions._internal();

  factory Functions() {
    return instance;
  }
double setAmoundNotifier=500;
Future <void>getSetamount()async{
  
   final sharedpre=await SharedPreferences.getInstance();
   double? setvalue=  sharedpre.getDouble('Dialylimit');
  setAmoundNotifier= setvalue??500;
  notifyListeners();
  
}

}


