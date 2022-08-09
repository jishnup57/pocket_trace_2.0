import 'package:flutter/material.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/Bills/bill_list.dart';
import 'package:one/view/Transactions/all_transactions.dart';
import 'package:one/view/settings/screensettings.dart';
import 'package:one/view/login/start.dart';
import 'package:one/view/widget/empty_list_show.dart';
import 'package:one/view/widget/lineprogressindicator.dart';
import 'package:one/view/widget/main_slidable_card.dart';
import 'package:one/view_model/category/CircularProgress/functions/functions.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:provider/provider.dart';
import '../../view/widget/circularprogressbar.dart';



class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
            child: username.isEmpty
                ? const Text(
                    'POCKET TRACE',
                    textScaleFactor: 1.2,
                    style: TextStyle(fontFamily: 'SettingsFont'),
                  )
                : Text(
                    'Welcome $username',
                    style: const TextStyle(fontFamily: 'SettingsFont'),
                  )),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const SreenSettings()))),
          child: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const ShowBill()))),
              child: const Icon(
                Icons.notifications,
              ),
            ),
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(15, 15),
          ),
        ),
        backgroundColor: kBlueColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff212236),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleProgress(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Daily Limit',
                      textScaleFactor: 1.8,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Lato',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    linearProgressIndicator(context),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<TransactionDB>(
                            
                              builder: (BuildContext ctx, expense, _) {
                                return Text(
                                  '₹ ${expense.todayTotalExpenceonly}',
                                  textScaleFactor: 1.5,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Schyler',
                                      fontWeight: FontWeight.w300),
                                );
                              }),
                          Consumer<Functions>(
                           
                            builder:
                                (BuildContext ctx, setval,  _) {
                              return Text(
                                '₹ ${setval.setAmoundNotifier}',
                                textScaleFactor: 1.5,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'Schyler',
                                    fontWeight: FontWeight.w300),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Transaction',
                            textScaleFactor: 1.4,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(243, 6, 46, 81)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const AllTransactions()));
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'See more',
                                  textScaleFactor: 1.4,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(243, 6, 46, 81)),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Consumer<TransactionDB>(
                      builder:(context, value, child) {
                        return value.allTransactionsList
                                .isNotEmpty
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    value.allTransactionsList.length < 5 ? value.allTransactionsList.length : 5,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 1,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final _value = value.allTransactionsList[index];
                                  return MainSlidableCard(
                                    value: _value,
                                  );
                                },
                              )
                            : emptyListBackground(context);
                      }, ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


