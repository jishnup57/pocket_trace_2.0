

import 'package:flutter/material.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/widget/popup.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
  //  double height=MediaQuery.of(context).size.height;
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: RawMaterialButton(
          onPressed: () {
            showPopUp(context);
          },
          elevation: 2.0,
          fillColor: appcolor.buttonBlue,
          child:
           Container(
            width: width/7,
            height: width/7,
            decoration:const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              size: width/9,
            ),
          ),
          padding:const EdgeInsets.all(13),
          shape:const CircleBorder(),
        ),
    );
  }
  // toPageCategory(context){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const CategoryScreen()));
  // }
}