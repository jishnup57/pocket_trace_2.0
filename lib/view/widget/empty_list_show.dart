import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget emptyListBackground(context) {
  double height = MediaQuery.of(context).size.height;
  return Column(
    children: [
      const SizedBox(height: 20,),
      
      Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: SvgPicture.asset(
          'asset/images/empty.svg',
          height: height / 3.1,
        ),
      ),
       const SizedBox(height: 20,),
      const Text('No Transaction Added',textScaleFactor: 1.6,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold
      ),),
    ],
  );
}
