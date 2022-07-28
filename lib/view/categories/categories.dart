import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/categories/expensecategorylist.dart';
import 'package:one/view/categories/incomecategorylist.dart';
import 'package:one/view_model/category/category_db.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
   int? selectedController;
   CategoryScreen({this.selectedController,Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final _nameCategoryController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this,initialIndex:widget.selectedController??0);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(25, 25),
        )),
        automaticallyImplyLeading: true,
        toolbarHeight: height/8,
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
            padding: const EdgeInsets.only(left:10,right:10),
            child: TabBar(
              controller: _tabController,
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
            controller: _tabController,
            children: [
              Padding(
                padding: EdgeInsets.all(width / 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
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
                          padding: EdgeInsets.only(left: width/25),
                          child: TextFormField(
                            maxLength: 15,
                            controller: _nameCategoryController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              hintText: 'New category name..',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final nameIncome =
                              _nameCategoryController.text.trim();
                          if (nameIncome.isEmpty) {
                            return;
                          }
                          final _category = CategoryModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: nameIncome,
                              type: CategoryType.income);
                          CategoryDB.instance.insertCategory(_category);
                          _nameCategoryController.clear();
                        },
                        child: const Text('Add+ ',
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          primary: kBlueColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .4,
                      width: double.infinity,
                      child: const IncomeCategoryList(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width / 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
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
                          padding:  EdgeInsets.only(left: width/25),
                          child: TextFormField(
                            controller: _nameCategoryController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              hintText: 'New category name..',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final nameExpense =
                              _nameCategoryController.text.trim();
                          if (nameExpense.isEmpty) {
                            return;
                          }
                          final _category = CategoryModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: nameExpense,
                              type: CategoryType.expense);
                          CategoryDB.instance.insertCategory(_category);
                          _nameCategoryController.clear();
                        },
                        child: const Text('Add+ ',
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          primary: kBlueColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .4,
                      width: double.infinity,
                      child: const ExpenseCategoryList(),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
