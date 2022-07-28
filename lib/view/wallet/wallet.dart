import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view_model/transaction/transaction_db.dart';


class ScreenWallet extends StatelessWidget {
 const ScreenWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(25, 25),
          ),
        ),
       // toolbarHeight: 100,
       toolbarHeight: height/8,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: width / 1.9, top: height / 75),
          child: SvgPicture.asset(
            'asset/images/wallet.svg',
            width: width / 2.5,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: height / 25),
          child: const Text('Wallet', textScaleFactor: 1.5),
        ),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Card(
          elevation: 4.0,
          color: const Color(0xff212236),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SizedBox(
            height: height / 3,
            width: width - 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               const Text(
                  'Total Amount',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.grey,
      
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  TransactionDB.instance.totalIncome.toString(),
                        textScaleFactor: 2.5,
                  style:const TextStyle(
                      color: Colors.white,
                      fontFamily: 'CourrierPrime'),
                ),
                     const Text(
                  'Balance Amount',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.grey,
      
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ( TransactionDB.instance.totalIncome- TransactionDB.instance.totalExpense<0?0:TransactionDB.instance.totalIncome- TransactionDB.instance.totalExpense).toString(),
                  textScaleFactor: 1.8,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),

  
    );
  }
}
