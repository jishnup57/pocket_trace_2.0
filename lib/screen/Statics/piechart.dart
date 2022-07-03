// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:one/db/category/transaction/transaction_db.dart';
// import 'package:pie_chart/pie_chart.dart';

// class PieCharts extends StatelessWidget {
//   Map<String,double>statics={
//     "Income":TransactionDB.instance.totalIncome,
//     "Expense":TransactionDB.instance.totalExpense
//   };
//   PieCharts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PieChart(dataMap:statics );
//   }
// }

import 'package:flutter/material.dart';
import 'package:one/db/category/transaction/transaction_db.dart';
import 'package:pie_chart/pie_chart.dart';

Widget overAllChart(){
  Map<String,double>statics={
    "Income":TransactionDB.instance.totalIncome,
    "Expense":TransactionDB.instance.totalExpense
  };
 return Column(
   children: [
    const SizedBox(
      height: 30,
    ),
     PieChart(dataMap: statics,
     chartRadius: 200,
     legendOptions: const LegendOptions(
      legendPosition:LegendPosition.right ),
     ),
   ],
 );
}