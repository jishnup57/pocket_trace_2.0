import 'package:flutter/material.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/Bills/bills.dart';
import 'package:one/view/Homepage/screen_main.dart';
import 'package:one/view/Statics/chart.dart';
import 'package:one/view/Wallet/wallet.dart';
import 'package:one/view/widget/bottomnav.dart';
import 'package:one/view/widget/floating_button.dart';


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
        backgroundColor: kBlueColor,
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
