

import 'package:flutter/material.dart';
import 'package:one/view_model/transaction/transaction_db.dart';

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