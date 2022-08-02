import 'package:flutter/material.dart';
import 'package:one/Model/category/category_model.dart';

class EditTrans with ChangeNotifier{
  
  DateTime? date;
  dynamic dropdownName;
  String? choice;
  CategoryType? selectedCategorytype;
  String? categotyid;
  CategoryModel? selectedCategorymodel;
  pickDate(BuildContext ctx,DateTime dBdate) async {
    final tempfirstdate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now(),
    );
    date = tempfirstdate ?? dBdate;
   
    notifyListeners();
   
  }
   dropdownButtonRebuild(dynamic dropdownName) {
    this.dropdownName = dropdownName;
    notifyListeners();
  }
  choiceChipRebuild(String choice) {
    this.choice = choice;
    
  }
  setCategoryType(CategoryType type){
    selectedCategorytype=type;
    notifyListeners();
    print(selectedCategorytype);
  }
  setDate(DateTime dateFromDb){
    date=dateFromDb;
    notifyListeners();
    print(date);
  }
   setCategoryModel(CategoryModel model){
    selectedCategorymodel=model;
    notifyListeners();
    print(selectedCategorymodel);
  }
    setcategotyid(String? model){
    categotyid=model;
    notifyListeners();
    print(categotyid);
  }
}