import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/util/constants.dart';

abstract class BillDbFunctions {
  Future<void> insertbill(BillModel obj);
  Future<void> deleteBill(String billID);
}

class BillDB extends BillDbFunctions with ChangeNotifier {
  BillDB() {
    refreshBillUI();
  }

 final List<BillModel> _billListLisener = [];

  List<BillModel> get allBillList=>_billListLisener;

  @override
  Future<void> deleteBill(String billID) async {
    final _billbox = await Hive.openBox<BillModel>(billdbname);
    await _billbox.delete(billID);
    refreshBillUI();
  }

  @override
  Future<void> insertbill(BillModel obj) async {
    final _billbox = await Hive.openBox<BillModel>(billdbname);
    _billbox.put(obj.id, obj);
    refreshBillUI();
  }

  Future<List<BillModel>> getBills() async {
    final _billbox = await Hive.openBox<BillModel>(billdbname);
    return _billbox.values.toList();
  }

  Future<void> refreshBillUI() async {
    final _allbills = await getBills();
    _billListLisener.clear();
    _billListLisener.addAll(_allbills);
    notifyListeners();
  }


}
