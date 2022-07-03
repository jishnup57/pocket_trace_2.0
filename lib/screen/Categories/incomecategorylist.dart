import 'package:flutter/material.dart';
import 'package:one/db/category/category_db.dart';
import 'package:one/widget/delete_popup.dart';

import '../../Model/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().listOfIncomeCategoryLisener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return GridView.builder(
          itemCount: newList.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
           mainAxisSpacing: 10,
           crossAxisSpacing: 10
          ),
          itemBuilder: (context, index) {
            final _category = newList[index];
            return InputChip(
              label: Text(_category.name),
              deleteIcon: const Icon(Icons.cancel),
              onDeleted: () {
                showDeletePopUp(context,categoryId: _category.id);
              },
            );
          },
        );
        },);
  }
}
