
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget emptyGraphBackground(context) {
  return Column(
    children: [
      const SizedBox(height: 20,),
       Lottie.asset('asset/lottie/emptyGraph.json'),
        
       const SizedBox(height: 20,),
      const Text('No Data To Display',textScaleFactor: 1.6,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold
      ),),
    ],
  );
}
