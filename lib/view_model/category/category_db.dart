import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one/Model/category/category_model.dart';

const categorydbname='category_database';
abstract class CategoryDbFunctions{
  Future< List<CategoryModel>>getCategories();
  Future <void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions{
  CategoryDB._interal();
  static CategoryDB instance=CategoryDB._interal();
  factory CategoryDB(){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> listOfIncomeCategoryLisener=ValueNotifier([]);
   ValueNotifier<List<CategoryModel>> listOfExpenseCategoryLisener=ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value)async {
   final _categoryDB=await Hive.openBox<CategoryModel>(categorydbname);
   _categoryDB.put(value.id,value);   //add id to db
   refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB=await Hive.openBox<CategoryModel>(categorydbname);
   return _categoryDB.values.toList();
  }
  Future <void> refreshUI()async{
    final _allCategories=await getCategories();
    listOfExpenseCategoryLisener.value.clear();
    listOfIncomeCategoryLisener.value.clear();
    Future.forEach(_allCategories, (CategoryModel category) {
      if(category.type==CategoryType.income){
        listOfIncomeCategoryLisener.value.add(category);
      }else{
        listOfExpenseCategoryLisener.value.add(category);
      }
    });
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    listOfExpenseCategoryLisener.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    listOfIncomeCategoryLisener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB=await Hive.openBox<CategoryModel>(categorydbname);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }

}