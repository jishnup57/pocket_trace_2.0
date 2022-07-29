import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/constants.dart';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
  Future<void> refreshUI();
}

class CategoryDB extends CategoryDbFunctions with ChangeNotifier {
  CategoryDB._interal();
  static CategoryDB instance = CategoryDB._interal();
  factory CategoryDB() {
    return instance;
  }
  List<CategoryModel> allIncomeList = [];
  List<CategoryModel> allExpenseList = [];
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    _categoryDB.put(value.id, value); //add id to db
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    return _categoryDB.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    allExpenseList.clear();
    allIncomeList.clear();
    Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        allIncomeList.add(category);
      } else {
        allExpenseList.add(category);
      }
    });
    notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
