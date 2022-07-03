import 'package:flutter/material.dart';
import 'package:one/db/category/category_db.dart';
import 'package:one/widget/delete_popup.dart';

import '../../Model/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().listOfExpenseCategoryLisener,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return GridView.builder(
          itemCount: newList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      },
    );
  }
}

// ListView.separated(
// physics: const BouncingScrollPhysics(),
// itemBuilder:(ctx,index){
//  final category=newList[index];
// return InputChip(
// label:Text(category.name),

// deleteIcon: Icon(Icons.cancel),
// onDeleted:(){} ,

// );

//  Padding(
//   padding: const EdgeInsets.only(top:8,left: 20,right: 20),
//   child: Card(
//     elevation: 4,
//     child: ListTile(
//       tileColor: Colors.grey[100],
//       title: Text(category.name,
//       textScaleFactor: 1.2,),
//       trailing:IconButton(onPressed: () {
//         CategoryDB.instance.deleteCategory(category.id);
//       }, icon:const Icon(Icons.delete,
//       color: Colors.red,
//       ),
//       )
//     ),
//   ),
// );

// separatorBuilder: (ctx,index){
//   return const SizedBox(
//     height: 10,
// //   );
// },
//  itemCount: newList.length);
