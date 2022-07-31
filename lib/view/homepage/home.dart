import 'package:flutter/material.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/Bills/bills.dart';
import 'package:one/view/Homepage/screen_main.dart';
import 'package:one/view/Statics/chart.dart';
import 'package:one/view/Wallet/wallet.dart';
import 'package:one/view/widget/floating_button.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(3);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
        elevation: 0,
        backgroundColor: kBlueColor,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          ScreenHome(),
          Chart(),
          ScreenWallet(),
          ScreenBills(),
        ],
      ),

      floatingActionButton: const AppFloatingButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 8.0)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: WaterDropNavBar(
            waterDropColor: kBlueColor,
            backgroundColor: Colors.white,
            onItemSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
              pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            },
            selectedIndex: selectedIndex,
            barItems: <BarItem>[
              BarItem(
                filledIcon: Icons.home,
                outlinedIcon: Icons.home_outlined,
              ),
              BarItem(
                  filledIcon: Icons.pie_chart,
                  outlinedIcon: Icons.pie_chart_outline),
              BarItem(
                filledIcon: Icons.account_balance_wallet,
                outlinedIcon: Icons.account_balance_wallet_outlined,
              ),
              BarItem(
                filledIcon: Icons.receipt_long,
                outlinedIcon: Icons.receipt_long_outlined,
              ),
            ],
          ),
        ),
      ),
      //    ),
    );
  }
}
