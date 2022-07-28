import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one/db/category/CircularProgress/featchdata.dart';
import 'package:one/db/transaction/transaction_db.dart';

import 'package:percent_indicator/percent_indicator.dart';

class CircleProgress extends StatefulWidget {
  const CircleProgress({Key? key}) : super(key: key);

  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress> {
  final ValueNotifier<String> _nameNotifier = ValueNotifier('');
  final ValueNotifier<double> _amountNotifier = ValueNotifier(1);
  //String? _nameCategory;
  @override
  void initState() {
   DataFeatchCircular.instance.refereshProgressbar().then((value) {
    setState(() {
      
    });
   });
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
   //  DataFeatchCircular.instance.refereshProgressbar();
    TransactionDB.instance.refresh();
    if (DataFeatchCircular.instance.progressListNotifier.value.isNotEmpty) {
      valueChanger();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    TransactionDB.instance.refresh();
    return DataFeatchCircular.instance.progressListNotifier.value.isEmpty&&TransactionDB.instance.totalExpense==0
        ? CircularPercentIndicator(
            radius: 60,
            lineWidth: 15,
            circularStrokeCap: CircularStrokeCap.round,
            percent: 0,
            animation: true,
            animationDuration: 1500,
            center: CircleAvatar(
              radius: 60 - 15,
              backgroundColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'No Data',
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Color(0xff62c3ff)),
                  ),
                  Text(
                    '0%',
                    textScaleFactor: 1.7,
                    style: TextStyle(color: Color(0xff62c3ff)),
                  ),
                ],
              ),
            ),
            progressColor: const Color(0xff46fed1),
            backgroundColor: const Color(0xff313540),
          )
        : ValueListenableBuilder(valueListenable: _amountNotifier, 
        builder:(BuildContext ctx, double _newIndicatorValue, Widget?_){
          return  CircularPercentIndicator(
              radius: 60,
              lineWidth: 15,
              circularStrokeCap: CircularStrokeCap.round,
              percent:(_newIndicatorValue / TransactionDB.instance.totalExpense)>1.0?0:_newIndicatorValue /TransactionDB.instance.totalExpense,
              //(_newIndicatorValue / TransactionDB.instance.totalExpense)>1&&(_newIndicatorValue / TransactionDB.instance.totalExpense)<0.001?0.00:(_newIndicatorValue / TransactionDB.instance.totalExpense),
              animation: true,
              animationDuration: 1500,
              center: CircleAvatar(
                radius: 60 - 15,
                backgroundColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _nameNotifier,
                      builder: (BuildContext ctx, String _newName, Widget? _) {
                        return Text(
                          _newName,
                          textScaleFactor: 1.2,
                          style: const TextStyle(color: Color(0xff62c3ff)),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: _amountNotifier,
                        builder: (BuildContext ctx, double _newValue, Widget? _) {
                          return Text(
                            convertToString(_newValue),
                            textScaleFactor: 1.7,
                            style: const TextStyle(color: Color(0xff62c3ff)),
                          );
                        })
                  ],
                ),
              ),
              progressColor: const Color(0xff46fed1),
              backgroundColor: const Color(0xff313540),
            );
        } );
  }
  valueChanger() async {
    _nameNotifier.value = DataFeatchCircular
        .instance.progressListNotifier.value[0].categories
        .toString();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    _nameNotifier.notifyListeners();
    _amountNotifier.value =
        DataFeatchCircular.instance.progressListNotifier.value[0].amount!;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    _amountNotifier.notifyListeners();
    for (var i = 1;
        i < DataFeatchCircular.instance.progressListNotifier.value.length;
        i++) {
      await Future.delayed(
        const Duration(seconds: 4),
        () {
          _nameNotifier.value = DataFeatchCircular
              .instance.progressListNotifier.value[i].categories
              .toString();
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _nameNotifier.notifyListeners();
          _amountNotifier.value =
              DataFeatchCircular.instance.progressListNotifier.value[i].amount!;
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _amountNotifier.notifyListeners();
          if (i==DataFeatchCircular.instance.progressListNotifier.value.length-1) {
            i=-1;
          }
        },
      );
    }
  }
String convertToString(double percentValue){
 int _value=(percentValue/TransactionDB.instance.totalExpense*100).toInt();
 _value>100?_value=0:_value=_value;
 String textValue=_value.toString();
 return(textValue+"%") ;
}
}
