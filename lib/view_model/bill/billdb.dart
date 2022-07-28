import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one/Model/bill/bill_model.dart';
const billdbname='bill_database';
abstract class BillDbFunctions {
  Future<void>insertbill(BillModel obj);
  Future<void> deleteBill(String billID);
}

class BillDB implements BillDbFunctions {
  BillDB._interal();
  static BillDB instance=BillDB._interal();
  factory BillDB(){
    return instance;
  }
  ValueNotifier<List<BillModel>> billListLisener = ValueNotifier([]);
  @override
  Future<void> deleteBill(String billID)async {
   final _billbox=await Hive.openBox<BillModel>(billdbname);
   await _billbox.delete(billID);
   refreshBillUI();
  }

  @override
  Future<void> insertbill(BillModel obj) async{
    final _billbox=await Hive.openBox<BillModel>(billdbname);
    _billbox.put(obj.id, obj);
    refreshBillUI();
  }
  Future<List<BillModel>> getBills()async{
    final _billbox=await Hive.openBox<BillModel>(billdbname);
    return _billbox.values.toList();
  }
  Future <void> refreshBillUI()async{
  final _allbills=await getBills();
  billListLisener.value.clear();
  billListLisener.value.addAll(_allbills);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  billListLisener.notifyListeners();
  }
 
  
}