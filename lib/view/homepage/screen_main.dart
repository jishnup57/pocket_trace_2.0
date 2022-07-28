import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/db/category/CircularProgress/functions/functions.dart';
import 'package:one/view/Bills/bill_list.dart';
import 'package:one/view/Transactions/all_transactions.dart';
import 'package:one/view/screen_edit/edit.dart';
import 'package:one/view/settings/screensettings.dart';
import 'package:one/view/login/start.dart';
import 'package:one/view/widget/delete_popup.dart';
import 'package:one/view/widget/empty_list_show.dart';
import 'package:one/view/widget/lineprogressindicator.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import '../../view/widget/circularprogressbar.dart';

const selectedDay = 'SelectedDay';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TransactionDB.instance.refresh();
    // Functions.instance.getSetamount();
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
        backgroundColor: appcolor.buttonBlue,
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
                    // CircularPercentIndicator(
                    //   radius: 60,
                    //   lineWidth: 15,
                    //   circularStrokeCap: CircularStrokeCap.round,
                    //   percent: 60 / 100,
                    //   animation: true,
                    //   animationDuration: 1500,
                    //   center: CircleAvatar(
                    //     radius: 60 - 15,
                    //     backgroundColor: Colors.transparent,
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Text(
                    //           'Food',
                    //           textScaleFactor: 1.3,
                    //           style: TextStyle(color: Color(0xff62c3ff)),
                    //         ),
                    //         Text(
                    //           '60%',
                    //           textScaleFactor: 1.7,
                    //           style: TextStyle(color: Color(0xff62c3ff)),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   progressColor: const Color(0xff46fed1),
                    //   backgroundColor: const Color(0xff313540),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Dially Limit',
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
                          ValueListenableBuilder(
                              valueListenable:
                                  TransactionDB.instance.todayExpenseNotifier,
                              builder: (BuildContext ctx, double _todayExpense,
                                  Widget? _) {
                                return Text(
                                  '₹ $_todayExpense',
                                  textScaleFactor: 1.5,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Schyler',
                                      fontWeight: FontWeight.w300),
                                );
                              }),
                          ValueListenableBuilder(
                            valueListenable:
                                Functions.instance.setAmoundNotifier,
                            builder:
                                (BuildContext ctx, double _setval, Widget? _) {
                              return Text(
                                '₹ $_setval',
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
                    ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.transactionListNotifier,
                      builder: (BuildContext ctx, List<TransationModel> newList,
                          Widget? _) {
                        return TransactionDB.instance.transactionListNotifier
                                .value.isNotEmpty
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    newList.length < 5 ? newList.length : 5,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 1,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final _value = newList[index];
                                  return Slidable(
                                    key: Key(_value.id!),
                                    startActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (ctx) {
                                            showDeletePopUp(context,
                                                transactionid: _value.id);
                                          },
                                          backgroundColor: Colors.transparent,
                                          foregroundColor:
                                              const Color(0xFFFE4A49),
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                       EditScreen(datas: _value)));
                                          },
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.green[800],
                                          icon: Icons.edit,
                                          label: 'Edit',
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      color: Colors.white70,
                                      elevation: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 6, top: 6, bottom: 6),
                                            height: 60,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff212236),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  parseDateMonth(_value.date),
                                                  textScaleFactor: 1.5,
                                                  style: const TextStyle(
                                                      fontFamily: 'styleDate',
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  parseDate(_value.date),
                                                  textScaleFactor: 1.3,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'styleDate'),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _value.category.name,
                                                    textScaleFactor: 1.6,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            243, 6, 46, 81),
                                                        fontFamily:
                                                            'CourrierPrime',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(_value.notes,
                                                      textScaleFactor: 1.2,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            243, 6, 46, 81),
                                                        fontFamily: 'Lato',
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              _value.type == CategoryType.income
                                                  ? Text(
                                                      '₹${_value.amound.toInt().toString()}',
                                                      textScaleFactor: 1.5,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'styleNum',
                                                          color: Colors
                                                              .green[800]))
                                                  : Text(
                                                      '₹${_value.amound.toInt().toString()}',
                                                      textScaleFactor: 1.5,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'styleNum',
                                                          color:
                                                              Colors.red[900]))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : emptyListBackground(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //drawer..........................................................
      // drawer: const AppDrawer(),
    );
  }

  String parseDateMonth(DateTime date) {
    final _date = DateFormat().add_MMMd().format(date);
    final _splitdate = _date.split(' ');
    return _splitdate.first;
  }

  String parseDate(DateTime date) {
    final _date = DateFormat().add_MMMd().format(date);
    final _splitdate = _date.split(' ');
    return _splitdate.last;
  }

  // Future<void> saveDate() async {
  //   var today = DateTime.now().toUtc().toIso8601String();
  //   final sharedpre = await SharedPreferences.getInstance();
  //   await sharedpre.setString(selectedDay, today);
  //   var date = await sharedpre.getString(selectedDay);
  //   DateTime dateTime = await DateTime.parse(date!).toLocal();
  //   int currentDay = await DateTime.now().day + 1;

  //   // dateTime is the date fectched from preferences
  //   if (dateTime.day != currentDay) {
  //     // Now its a new day
  //     print('new day');
  //   }
  // }
}
