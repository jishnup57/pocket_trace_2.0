import 'package:flutter/material.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/view/Homepage/home.dart';

// ignore: must_be_immutable
class AppBottomNavBar extends StatelessWidget {
  AppBottomNavBar({Key? key}) : super(key: key);
  int? newIndex;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int changer, Widget? _) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: height / 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, -0.5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //left nav bar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          newIndex = 3;
                          MainScreen.selectedIndexNotifier.value = newIndex!;
                          /*
                          setState() */
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                changer == 3 ? Icons.home : Icons.home_outlined,
                                color: appcolor.buttonBlue,
                                size: width / 12),
                            changer == 3
                                ? const Text(
                                    'Home',
                                    textScaleFactor: 0.8,
                                    style:
                                        TextStyle(color: appcolor.buttonBlue),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          newIndex = 1;
                          MainScreen.selectedIndexNotifier.value = newIndex!;
                          /*
                          setState() */
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                changer == 1
                                    ? Icons.pie_chart
                                    : Icons.pie_chart_outline,
                                color: appcolor.buttonBlue,
                                size: width / 12),
                            changer == 1
                                ? const Text(
                                    'Statics',
                                    textScaleFactor: 0.8,
                                     style:
                                        TextStyle(color: appcolor.buttonBlue),
                                  )
                                  
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //right nav bar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          newIndex = 2;
                          MainScreen.selectedIndexNotifier.value = newIndex!;
                          /*
                          setState() */
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                changer == 2
                                    ? Icons.account_balance_wallet
                                    : Icons.account_balance_wallet_outlined,
                                color: appcolor.buttonBlue,
                                size: width / 12),
                            //  Text(changer==2?'Wallet':'',
                            //   textScaleFactor: 0.8,),
                            changer == 2
                                ? const Text(
                                    'Wallet',
                                    textScaleFactor: 0.8,
                                     style:
                                        TextStyle(color: appcolor.buttonBlue),
                                  
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          newIndex = 0;
                          MainScreen.selectedIndexNotifier.value = newIndex!;
                          /*
                          setState() */
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                changer == 0
                                    ? Icons.receipt_long
                                    : Icons.receipt_long_outlined,
                                color: appcolor.buttonBlue,
                                size: width / 12),
                            changer == 0
                                ? const Text(
                                    'Bills',
                                    textScaleFactor: 0.8,
                                     style:
                                        TextStyle(color: appcolor.buttonBlue),
                                  
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
