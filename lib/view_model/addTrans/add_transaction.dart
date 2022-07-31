import 'package:flutter/material.dart';

class AddTrans with ChangeNotifier {
  dynamic dropdownName;
  DateTime date=DateTime.now();
  dropdownButtonRebuild(dynamic dropdownName) {
    this.dropdownName = dropdownName;
    notifyListeners();
  }

    pickDate(BuildContext ctx) async {
    final tempfirstdate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now(),
    );
    date = tempfirstdate ?? DateTime.now();
    notifyListeners();
   
  }

}
