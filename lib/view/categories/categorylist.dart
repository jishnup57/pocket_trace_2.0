import 'package:flutter/material.dart';
import 'package:one/view/widget/delete_popup.dart';
import 'package:one/view_model/category/category_db.dart';


class CategoryList extends StatelessWidget {
   const CategoryList({Key? key,required this.value,required this.type}) : super(key: key);
 final CategoryDB value;
 final String type;
  @override
  Widget build(BuildContext context) {
  
        return GridView.builder(
          itemCount:type=="INC" ?value.allIncomeList.length:value.allExpenseList.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
           mainAxisSpacing: 10,
           crossAxisSpacing: 10
          ),
          itemBuilder: (context, index) {
            final _category =type=="INC"? value.allIncomeList[index]:value.allExpenseList[index];
            return InputChip(
              label: Text(_category.name),
              deleteIcon: const Icon(Icons.cancel),
              onDeleted: () {
                showDeletePopUp(context,categoryId: _category.id);
              },
            );
          },
        );
     
  }
}
