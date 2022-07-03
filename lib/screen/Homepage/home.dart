import 'package:flutter/material.dart';
import 'package:one/screen/Bills/bills.dart';
import 'package:one/screen/Homepage/screen_main.dart';
import 'package:one/screen/Statics/chart.dart';
import 'package:one/screen/Wallet/wallet.dart';
import 'package:one/widget/bottomnav.dart';
import 'package:one/widget/floating_button.dart';
import 'package:one/color/app_colors.dart' as appcolor;

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  static ValueNotifier <int> selectedIndexNotifier=ValueNotifier(3);
  final pages=[
   const ScreenBills(),
   const Chart(),
    const ScreenWallet(),
    const ScreenHome()
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
        elevation: 0,
        backgroundColor: appcolor.buttonBlue,
      ),
      body: SafeArea(
        child:ValueListenableBuilder(valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _){
          return pages[updatedIndex];
        },
        )
         ),

     floatingActionButton: const AppFloatingButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:  AppBottomNavBar()
      
    );
  }
}
