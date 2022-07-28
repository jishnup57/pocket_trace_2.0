import 'package:flutter/material.dart';
import 'package:one/db/category/CircularProgress/functions/chartfunction.dart';



import '../../transaction/transaction_db.dart';


class DataFeatchCircular {
  DataFeatchCircular._interal();
  static DataFeatchCircular instance=DataFeatchCircular._interal();
  factory DataFeatchCircular(){
    return instance;
  }

  

    ValueNotifier<List<ChartData>> progressListNotifier=ValueNotifier([]);
    

  
 Future<void> refereshProgressbar()async{
    
    final datas =
      chartLogic(TransactionDB.instance.expenceListNotifier.value);
      progressListNotifier.value.clear();
      progressListNotifier.value.addAll(datas);
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      progressListNotifier.notifyListeners();
  }
}