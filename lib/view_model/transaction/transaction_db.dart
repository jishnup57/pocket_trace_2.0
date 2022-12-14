import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/constants.dart';
import 'package:one/view_model/category/category_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TransactionFunctions {
  Future<void> addTransactions(TransationModel object);
  Future<List<TransationModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> updateTransactionToDB(TransationModel model, String id);
  Future<void> resetTransactrion();
}

class TransactionDB extends TransactionFunctions with ChangeNotifier{
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  double totalIncome = 0;
  double totalExpense = 0;
  double todayExpense = 0;

 
      List<TransationModel> allTransactionsList=[];
  ValueNotifier<List<TransationModel>> incomListNotifier = ValueNotifier([]);
      List<TransationModel> allIncomeList=[];
  ValueNotifier<List<TransationModel>> expenceListNotifier = ValueNotifier([]);
    List<TransationModel> allExpenceList=[];
 
      double todayTotalExpenceonly=0;
  //day list notifiers
  //
  //
  ValueNotifier<List<TransationModel>> todayListNotifier = ValueNotifier([]);
    List<TransationModel> todayAllList=[];
  ValueNotifier<List<TransationModel>> yesterdayListNotifier =
      ValueNotifier([]);
      List<TransationModel> yesterdayAllList=[];
  ValueNotifier<List<TransationModel>> monthelyListNotifier = ValueNotifier([]);
      List<TransationModel> monthlyAllList=[];
  ValueNotifier<List<TransationModel>> customListNotifier = ValueNotifier([]);
        List<TransationModel> customAllList=[];
  //Global date assign
  String todayDate = DateFormat.yMd().format(DateTime.now());
  String yesterdayDate =
      DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 1)));
  // ignore: non_constant_identifier_names
  String MonthlyDate = DateFormat.yMd()
      .format(DateTime.now().subtract(const Duration(days: 30)));

  @override
  Future<void> addTransactions(TransationModel object) async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    await transactionBox.put(object.id, object);
    refresh();
  }

  Future<void> refresh() async {
    var _list = await getAllTransactions();
    allTransactionsList.clear();
    _list = _list.reversed.toList();
    _list.sort((first, second) => second.date.compareTo(first.date));
 
    allTransactionsList.addAll(_list);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  

    totalIncome = 0;
    totalExpense = 0;
    todayExpense = 0;
  
    todayTotalExpenceonly=0;
    incomListNotifier.value.clear();
    allIncomeList.clear();
    expenceListNotifier.value.clear();
    allExpenceList.clear();
    DateTime dateToday = DateTime.now();

    String newDate = DateFormat('yMd').format(dateToday);
    for (var element in _list) {
      if (element.type == CategoryType.income) {
        incomListNotifier.value.add(element);
        allIncomeList.add(element);
        totalIncome = totalIncome + element.amound;
      } else {
        expenceListNotifier.value.add(element);
        allExpenceList.add(element);
        totalExpense = totalExpense + element.amound;
        String dat = DateFormat('yMd').format(element.date);
        if (dat == newDate) {
          todayExpense = todayExpense + element.amound;
     
          todayTotalExpenceonly=todayExpense;
        }
      }
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    incomListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    expenceListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

    notifyListeners();
  }

  @override
  Future<List<TransationModel>> getAllTransactions() async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    return transactionBox.values.toList();
  }

  @override
  Future<void> deleteTransaction(Pattern id) async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    await transactionBox.delete(id);
    refresh();
  }

  @override
  Future<void> updateTransactionToDB(TransationModel model, String id) async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    transactionBox.put(id, model);
  }

  @override
  Future<void> resetTransactrion() async {
    final transactionBox =
        await Hive.openBox<TransationModel>(transactiondbname);
    await transactionBox.clear();
    final _categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    await _categoryDB.clear();
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.setBool(loginKey, false);
    await refresh();
    await CategoryDB.instance.refreshUI();
  }

  Future<void> filtration(List<TransationModel> selectedlist) async {

    todayListNotifier.value.clear();
    todayAllList.clear();
    yesterdayListNotifier.value.clear();
    yesterdayAllList.clear();
    monthelyListNotifier.value.clear();
    monthlyAllList.clear();
    await Future.forEach(selectedlist, (TransationModel singleModel) {
      String eachModelDate = DateFormat.yMd().format(singleModel.date);

      if (todayDate == eachModelDate) {
        todayListNotifier.value.add(singleModel);
        todayAllList.add(singleModel);
      }
      if (yesterdayDate == eachModelDate) {
        yesterdayListNotifier.value.add(singleModel);
        yesterdayAllList.add(singleModel);
      }
  
    });
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    todayListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    yesterdayListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    monthelyListNotifier.notifyListeners();
    notifyListeners();
  }

  Future<void> customFiltration(
      {required List<TransationModel> selectedlist,
      required DateTime firstDate,
      required DateTime lastDate}) async {
    customListNotifier.value.clear();
    int first = int.parse(DateFormat('yyyyMMdd').format(firstDate));
    int last = int.parse(DateFormat('yyyyMMdd').format(lastDate));

    await Future.forEach(selectedlist, (TransationModel singleModel) {
      int modelDate =
          int.parse(DateFormat('yyyyMMdd').format(singleModel.date));

      if (modelDate >= first && modelDate <= last) {
        customListNotifier.value.add(singleModel);
        customAllList.add(singleModel);
      }
    });
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    customListNotifier.notifyListeners();
    notifyListeners();
  }
}
