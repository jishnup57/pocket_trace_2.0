import 'package:flutter/material.dart';
import 'package:one/view/Categories/categories.dart';
import 'package:one/view/addexpense/expense.dart';

import '../addincome/income.dart';


Future<void>showPopUp(BuildContext context)async{
  showDialog(context: context,
   builder: (ctx){
     return SimpleDialog(
       
       backgroundColor: Colors.transparent,
       children: [
          InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => const Income()));
                  },
                  child: Card(
                    elevation: 8,
                    child: Container(
                      color: Colors.green[900],
                      height: 60,
                      width: 150,
                      child: const Center(
                        child: Text(
                          '+Income',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) =>  Expense()));
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Container(
                      height: 60,
                      width: 150,
                      color: Colors.red[900],
                      child: const Center(
                        child: Text(
                          '+Expense',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => CategoryScreen()));
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 60,
                      width: 150,
                      color: Colors.black,
                      child:const Center(
                        child: Text(
                          '+Category',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
       ],
     );
   });
}