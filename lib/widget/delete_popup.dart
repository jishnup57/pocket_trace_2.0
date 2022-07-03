 import 'package:flutter/material.dart';
import 'package:one/db/category/category_db.dart';
import 'package:one/db/category/transaction/transaction_db.dart';

Future<void> showDeletePopUp(BuildContext context,{transactionid,categoryId}) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          children: [
           const Center(
                child: Text(
              'Are you want to delete!',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                     Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    'No',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                 TextButton(
                  onPressed: () {
                    if (transactionid!=null) {
                      TransactionDB.instance.deleteTransaction(transactionid);
                    } 
                    if (categoryId!=null) {
                      CategoryDB.instance.deleteCategory(categoryId);
                    }
                     Navigator.of(ctx).pop();
                  },
                  child:const Text(
                    'Yes',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
               
               
              ],
            )
          ],
        );
      },
    );
  }