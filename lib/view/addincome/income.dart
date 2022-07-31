import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/Categories/categories.dart';
import 'package:one/view/widget/snakbar.dart';
import 'package:one/view_model/addTrans/add_transaction.dart';
import 'package:one/view_model/category/category_db.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:provider/provider.dart';

import '../../Model/Transaction/transaction_model.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  DateTime _selectedDate = DateTime.now();
  final CategoryType? _selectedCategoryType = CategoryType.income;
  CategoryModel? _selectedCategoryModel;
  String? categoryId;
  final _notesEditingController = TextEditingController();
  final _amoundEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(25, 25),
        )),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: InkWell(
              onTap: () {
                context.read<AddTrans>().dropdownName = null;
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back)),
        ),
        toolbarHeight: 100,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(right: width / 2, top: height / 17),
          child: SvgPicture.asset(
            'asset/images/income.svg',
            width: width / 4,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: height / 25),
          child: const Text('Income', textScaleFactor: 1.5),
        ),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: width / 90, right: width / 90, top: height / 18),
        child: Container(
          height: height / 1.4,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 210, 208, 202),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          ' Date :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: width / 15, left: width / 12),
                          height: height / 15,
                          width: width / 1.9,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Consumer<AddTrans>(
                            builder: (context, value, _) => TextButton.icon(
                              onPressed: () async {
                                value.pickDate(context);
                                _selectedDate = value.date;
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                size: height / 25,
                                color: Colors.black54,
                              ),
                              label: Text(
                                  // ignore: unnecessary_null_comparison
                                  _selectedDate == null
                                      ? 'Select Date'
                                      : DateFormat('MMMMd').format(value.date),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          '  Amount :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: width / 15, left: width / 12),
                          height: height / 15,
                          width: width / 1.9,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Colors.white),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: width / 30),
                              child: TextFormField(
                                controller: _amoundEditingController,
                                keyboardType: TextInputType.number,
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  hintText: 'Enter the Amount..',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Category :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: width / 15, left: width / 12),
                          height: height / 15,
                          width: width / 1.9,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Colors.white),
                          child: context
                                  .read<CategoryDB>()
                                  .allIncomeList
                                  .isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(width / 30),
                                  child: Consumer<AddTrans>(
                                    builder: (context, value, _) =>
                                        DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const Text(
                                          'select Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54),
                                        ),
                                        value: value.dropdownName,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: context
                                            .read<CategoryDB>()
                                            .allIncomeList
                                            .map((e) {
                                          return DropdownMenuItem(
                                              child: Text(e.name),
                                              value: e.id,
                                              onTap: () {
                                                // print(e);
                                                _selectedCategoryModel = e;
                                              });
                                        }).toList(),
                                        onChanged: (selectedValue) {
                                          //  print(selectedValue);
                                          value.dropdownButtonRebuild(
                                              selectedValue);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => CategoryScreen(
                                                  selectedController: 0,
                                                )));
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.black54,
                                  ),
                                  label: const Text(
                                    'Add Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          '    Note :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: width / 15, left: width / 12),
                          height: height / 8,
                          width: width / 1.9,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Colors.white),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: width / 30),
                              child: TextFormField(
                                controller: _notesEditingController,
                                minLines: 2,
                                maxLines: 5,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Enter notes',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height / 12,
                          width: width / 1.5,
                          child: ElevatedButton(
                            onPressed: () {
                              addTransaction(context);
                            },
                            child: const Text('Add To Transactions',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                primary: kBlueColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction(BuildContext context) async {
    final _notes = _notesEditingController.text.trim();
    final _amound = _amoundEditingController.text.trim();
    categoryId = context.read<AddTrans>().dropdownName;
    if (_amound.isEmpty) {
      snakBarShow(context);
      return;
    }
    if (categoryId == null) {
      snakBarShow(context);
      return;
    }

    final convertedAmound = double.tryParse(_amound);
    if (convertedAmound == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      snakBarShow(context);
      return;
    }
    final _model = TransationModel(
      amound: convertedAmound,
      date: _selectedDate,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
      notes: _notes,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    context.read<TransactionDB>().addTransactions(_model);
    context.read<AddTrans>().dropdownName = null;
    context.read<AddTrans>().date = DateTime.now();
    Navigator.of(context).pop();
  }
}
