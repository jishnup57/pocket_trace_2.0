

import 'package:flutter/material.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/widget/popup.dart';


class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: FloatingActionButton.extended(onPressed: () {
         showPopUp(context);
      }, label: const Icon(Icons.add) ,
      backgroundColor: kBlueColor,
      )

    );
  }

}