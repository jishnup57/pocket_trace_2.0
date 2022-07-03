import 'package:flutter/material.dart';

void snakBarShow(context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    duration: Duration(milliseconds: 1000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
    margin: EdgeInsets.all(20),
    content: Text('All fields are Required')));
}