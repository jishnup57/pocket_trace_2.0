import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/constants.dart';

class AllTransCtrl with ChangeNotifier {
  AllTransCtrl._interal();
  static AllTransCtrl instance = AllTransCtrl._interal();
  factory AllTransCtrl() {
    return instance;
  }
  // AllTransCtrl() {
  //   refreshUI();
  // }

  String choice = 'All';
  String drodownName = 'All';
  List<String> items = ['All', 'Today', 'Yesterday', 'Monthly', 'Coustom'];
  DateTime todayDate = DateTime.now();
  DateTime pickedmonth = DateTime.now();
  DateTime firstdate = DateTime.now();
  DateTime lastdate = DateTime.now();
  List<TransationModel> allTransactionList = [];
  List<TransationModel> allTransactionListIncome = [];
  List<TransationModel> allTransactionListExpense = [];
  List<TransationModel> mainSelectedlist = [];
  List<TransationModel> tempSelectedList = [];
  List<TransationModel> filterdList = [];

  refreshUI() async {
    filterdList = await filtration(tempSelectedList, drodownName);
    notifyListeners();
  }

  choiceChipRebuild(String choice) {
    this.choice = choice;
    listSelector();
    refreshUI();
  }

  dropdownButtonRebuild(dynamic drodownName) {
    this.drodownName = drodownName;
    refreshUI();
  }

  pickMonth(BuildContext ctx) async {
    final tempmonth = await showMonthYearPicker(
      context: ctx,
      initialDate: todayDate,
      firstDate: DateTime(2020),
      lastDate: todayDate,
    );
    pickedmonth = tempmonth ?? DateTime.now();
    refreshUI();
  }

  pickFirstDate(BuildContext ctx) async {
    final tempfirstdate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now(),
    );
    firstdate = tempfirstdate ?? DateTime.now();
    refreshUI();
  }

  pickLastDate(BuildContext ctx) async {
    final tempLast = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: firstdate,
      lastDate: DateTime.now(),
    );
    lastdate = tempLast ?? DateTime.now();
    refreshUI();
  }

  listSelector() async {
    tempSelectedList.clear();
    allTransactionList.clear();
    allTransactionListIncome.clear();
    allTransactionListExpense.clear();
    allTransactionList = await getAllTransactions();
    for (var element in allTransactionList) {
      if (element.type == CategoryType.income) {
        allTransactionListIncome.add(element);
      }else{
        allTransactionListExpense.add(element);
      }
    }

    switch (choice) {
      case 'All':
        tempSelectedList.addAll(allTransactionList);
        print('alllll');

        break;
      case 'Income':
        tempSelectedList.addAll(allTransactionListIncome);
        print('incomee');
        break;
      default:
        tempSelectedList.addAll(allTransactionListExpense);
        print('exxx');
    }
  }




  Future<List<TransationModel>> getAllTransactions() async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    return transactionBox.values.toList();
  }

  Future<List<TransationModel>> filtration(
      List<TransationModel> selectedlist, dynamic drodownName) async {
    mainSelectedlist.clear();
    // print('$choice--->$drodownName');
    // List<TransationModel> todayAllList = [];
    // List<TransationModel> yesterdayAllList = [];
    // List<TransationModel> monthlyList = [];
    // List<TransationModel> customAllList = [];
    final todayDateString = DateFormat.yMd().format(DateTime.now());
    final yesterdayDate = DateFormat.yMd()
        .format(DateTime.now().subtract(const Duration(days: 1)));
    int first = int.parse(DateFormat('yyyyMMdd').format(firstdate));
    int last = int.parse(DateFormat('yyyyMMdd').format(lastdate));
 print('$choice--->$drodownName');
    await Future.forEach(tempSelectedList, (TransationModel singleModel) {
      
      //  print('${singleModel.date.month}---->${pickedmonth.month}');
      String eachModelDate = DateFormat.yMd().format(singleModel.date);
      int modelDate =
          int.parse(DateFormat('yyyyMMdd').format(singleModel.date));
      if (drodownName == 'All') {
        mainSelectedlist.add(singleModel);
      } else if (drodownName == 'Today' && todayDateString == eachModelDate) {
        //  todayAllList.add(singleModel);
        mainSelectedlist.add(singleModel);
      } else if (drodownName == 'Yesterday' && yesterdayDate == eachModelDate) {
        // yesterdayAllList.add(singleModel);
        mainSelectedlist.add(singleModel);
      } else if (drodownName == 'Monthly' &&
          singleModel.date.month == pickedmonth.month &&
          singleModel.date.year == pickedmonth.year) {
        // monthlyList.add(singleModel);
        mainSelectedlist.add(singleModel);
      } else {
        if (
          modelDate >= first &&
          modelDate <= last) {
        // customAllList.add(singleModel);
         print('$choice--->$drodownName');
        mainSelectedlist.add(singleModel);
      }
      }
    });

    return mainSelectedlist;
  }
}
