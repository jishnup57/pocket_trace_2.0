import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/categories/categorylist.dart';
import 'package:one/view_model/category/category_db.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final int? selectedController;
  CategoryScreen({this.selectedController, Key? key}) : super(key: key);

  final _nameCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      initialIndex: selectedController ?? 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(25, 25),
          )),
          automaticallyImplyLeading: true,
          toolbarHeight: height / 8,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(left: width / 1.5, top: height / 20),
            child: SvgPicture.asset(
              'asset/images/cat.svg',
              width: width / 4,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: height / 15),
            child: const Text('Categories', textScaleFactor: 1.7),
          ),
          backgroundColor: kBlueColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: height / 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey,
                ),
                labelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(width / 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      addTextField(height, width, 'New Income category name'),
                      addButtonCategory(context, CategoryType.income),
                      SizedBox(
                        height: height * .4,
                        width: double.infinity,
                        child: Consumer<CategoryDB>(
                            builder: (context, value, child) => CategoryList(
                                  value: value,
                                  type: "INC",
                                )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width / 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      addTextField(height, width, 'New Expense category name'),
                      addButtonCategory(context, CategoryType.expense),
                      SizedBox(
                        height: height * .4,
                        width: double.infinity,
                        child: Consumer<CategoryDB>(
                          builder: (context, value, child) => CategoryList(
                            value: value,
                            type: "EXP",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Container addTextField(double height, double width, String hintText) {
    return Container(
      height: height / 15,
      width: width / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(width / 28),
        ),
        color: kGrayColor,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width / 25),
          child: TextFormField(
            controller: _nameCategoryController,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox addButtonCategory(BuildContext context, CategoryType type) {
    return SizedBox(
      height: 38,
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          final nameExpense = _nameCategoryController.text.trim();
          if (nameExpense.isEmpty) {
            return;
          }
          final _category = CategoryModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: nameExpense,
              type: type);
          context.read<CategoryDB>().insertCategory(_category);
          _nameCategoryController.clear();
        },
        child: const Text('Add+ ',
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          primary: kBlueColor,
        ),
      ),
    );
  }
}
