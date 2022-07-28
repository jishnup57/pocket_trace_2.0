import 'package:flutter/material.dart';
import 'package:one/db/category/CircularProgress/functions/functions.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget linearProgressIndicator(context) {
  final double width = MediaQuery.of(context).size.width;
  return ValueListenableBuilder(
    valueListenable: Functions.instance.setAmoundNotifier,
    builder: (BuildContext ctx, double _setValue, Widget? _) {
      return ValueListenableBuilder(
          valueListenable: TransactionDB.instance.todayExpenseNotifier,
          builder: (BuildContext ctx, double _expence, _) {
            return LinearPercentIndicator(
              width: width - 20,
              lineHeight: 8,
              percent:
                  ((_expence / _setValue) > 1.0 || (_expence / _setValue) < 0.0)
                      ? 1.0
                      : (_expence / _setValue),
              animation: true,
              barRadius: const Radius.circular(10),
              animationDuration: 2500,

              //progressColor: const Color(0xFF66ccfc),
              linearGradient: LinearGradient(
                colors: (_expence / _setValue) < 0.60
                    ? [const Color(0xFF66ccfc), const Color(0xFF66ccfc)]
                    :((_expence / _setValue) <0.90? [const Color(0xFF66ccfc), Colors.red]:[Colors.redAccent, Colors.redAccent]),
              ),
              backgroundColor: const Color(0xff313540),
            );
          });
    },
  );
}
