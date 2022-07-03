import 'package:one/Model/Transaction/transaction_model.dart';

class ChartData {
  String? categories;
  double? amount;
  ChartData({required this.categories, required this.amount});
}

chartLogic(List<TransationModel> model) {
  double value;
  String categoryName;
  List visited = [];
  List<ChartData> thedata = [];
  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }

  for (var i = 0; i < model.length; i++) {
    value = model[i].amound;
    categoryName = model[i].category.name;

    for (var j = i + 1; j < model.length; j++) {
      if (model[i].category.name == model[j].category.name) {
        value += model[j].amound;
        visited[j] = -1;
      }
    }
    if (visited[i]!=-1) {
      thedata.add(ChartData(categories: categoryName, amount: value));
    }
  }
  return thedata;
}
