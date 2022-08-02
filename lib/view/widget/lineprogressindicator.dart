import 'package:flutter/material.dart';

import 'package:one/view_model/category/CircularProgress/functions/functions.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

Widget linearProgressIndicator(context) {
  final double width = MediaQuery.of(context).size.width;
  return Consumer<Functions>(  
    builder: ( ctx,  value,_) {
      return Consumer<TransactionDB>(
          
          builder: (BuildContext ctx, expence, _) {
            return LinearPercentIndicator(
              width: width - 20,
              lineHeight: 8,
              percent:
                  ((expence.todayTotalExpenceonly / value.setAmoundNotifier) > 1.0 || (expence.todayTotalExpenceonly / value.setAmoundNotifier) < 0.0)
                      ? 1.0
                      : (expence.todayTotalExpenceonly / value.setAmoundNotifier),
              animation: true,
              barRadius: const Radius.circular(10),
              animationDuration: 2500,

              //progressColor: const Color(0xFF66ccfc),
              linearGradient: LinearGradient(
                colors: (expence.todayTotalExpenceonly / value.setAmoundNotifier) < 0.60
                    ? [const Color(0xFF66ccfc), const Color(0xFF66ccfc)]
                    :((expence.todayTotalExpenceonly / value.setAmoundNotifier) <0.90? [const Color(0xFF66ccfc), Colors.red]:[Colors.redAccent, Colors.redAccent]),
              ),
              backgroundColor: const Color(0xff313540),
            );
          });
    },
  );
}
