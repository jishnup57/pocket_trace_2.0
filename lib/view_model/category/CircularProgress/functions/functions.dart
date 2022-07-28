


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions{

Functions._internal();

  static Functions instance = Functions._internal();

  factory Functions() {
    return instance;
  }
ValueNotifier<double>setAmoundNotifier=ValueNotifier(500);
Future <void>getSetamount()async{
  
   final sharedpre=await SharedPreferences.getInstance();
   double? setvalue=  sharedpre.getDouble('Dialylimit');
  setAmoundNotifier.value= setvalue??500;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  setAmoundNotifier.notifyListeners();
  
}

}


