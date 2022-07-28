import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/view_model/category/category_db.dart';
import 'package:one/view_model/transaction/transaction_db.dart';


// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  TransationModel datas;
  EditScreen({required this.datas, Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  CategoryModel? _selectedCategorymodel;
  CategoryType? _selectedCategorytype;
  DateTime? _selecteddate;
  String? _categotyid;

  @override
  void initState() {
    super.initState();
    _selectedCategorytype = widget.datas.category.type;
    _selecteddate = widget.datas.date;
    _selectedCategorymodel = widget.datas.category;
    _amountController.text = widget.datas.amound.toString();
    _notesController.text = widget.datas.notes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(25, 25),
        )),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back)),
        ),
        toolbarHeight: height/8,
        title: Padding(
          padding: EdgeInsets.only(top: height / 25),
          child: const Text('Edit Transaction', textScaleFactor: 1.5),
        ),
        backgroundColor: appcolor.buttonBlue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: width / 90, right: width / 90, top: height / 80),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                label: const Text(
                                  'Income',
                                  style: TextStyle(
                                      //  color:_selectedCategorytype==CategoryType.income?Colors.white:Colors.black,
                                      ),
                                ),
                                selected:
                                    _selectedCategorytype == CategoryType.income
                                        ? true
                                        : false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                selectedColor: Colors.green,
                                onSelected: (value) {
                                  setState(() {
                                    _selectedCategorytype = CategoryType.income;
                                    _categotyid = null;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ChoiceChip(
                                label: const Text(
                                  'Expense',
                                  style: TextStyle(
                                      //  color: _selectedCategorytype==CategoryType.expense?Colors.white:Colors.black,
                                      ),
                                ),
                                selected: _selectedCategorytype ==
                                        CategoryType.expense
                                    ? true
                                    : false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                selectedColor: Colors.red,
                                onSelected: (value) {
                                  setState(() {
                                    _selectedCategorytype =
                                        CategoryType.expense;
                                    _categotyid = null;
                                  });
                                },
                              ),
                            ],
                          ),

                       SizedBox(
                            height: height/23,
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
                                child: TextButton.icon(
                                  onPressed: () async {
                                    final _selectedDateTemp =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                              const Duration(days: 30),
                                            ),
                                            lastDate: DateTime.now());
                                    if (_selectedDateTemp == null) {
                                      widget.datas.date.toString();
                                    } else {
                                      setState(() {
                                        _selecteddate = _selectedDateTemp;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.calendar_month,
                                    size: height / 25,
                                    color: Colors.black54,
                                  ),
                                  label: Text(
                                      _selecteddate == null
                                          ? ""
                                          : DateFormat.MMMEd()
                                              .format(_selecteddate!),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54)),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(
                            height: height/23,
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
                                    padding:  EdgeInsets.only(left: width/30),
                                    child: TextFormField(
                                      controller: _amountController,
                                      maxLength: 7,
                                      keyboardType: TextInputType.number,
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
                            height: height/23,
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
                                child: Padding(
                                  padding:  EdgeInsets.all(width/30),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: _categotyid,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      hint: _selectedCategorytype ==
                                              widget.datas.type
                                          ? Text(widget.datas.category.name)
                                          : const Text(
                                              'Select Category',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54),
                                            ),
                                      items: (_selectedCategorytype ==
                                                  CategoryType.income
                                              ? CategoryDB
                                                  .instance
                                                  .listOfIncomeCategoryLisener
                                                  .value
                                              : CategoryDB
                                                  .instance
                                                  .listOfExpenseCategoryLisener
                                                  .value)
                                          .map(
                                        (e) {
                                          return DropdownMenuItem(
                                            child: Text(e.name),
                                            value: e.id,
                                            onTap: () {
                                              _selectedCategorymodel = e;
                                            },
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? selectedValue) {
                                        setState(() {
                                          _categotyid = selectedValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(
                            height: height/23,
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
                                    padding:  EdgeInsets.only(left:width/30),
                                    child: TextFormField(
                                      controller: _notesController,
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
                            height: height / 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height / 12,
                                width: width / 1.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    updateTransaction();
                                  },
                                  child: const Text('Add To Transactions',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      primary: appcolor.buttonBlue),
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
          ),
        ],
      ),
    );
  }

  Future<void> updateTransaction() async {
    final _notes = _notesController.text.trim();
    final _amount = _amountController.text.trim();
    final _parsedAmound = double.tryParse(_amount);
    final _model = TransationModel(
      amound: _parsedAmound!,
      date: _selecteddate!,
      type: _selectedCategorytype!,
      category: _selectedCategorymodel!,
      notes: _notes,
      id: widget.datas.id,
    );
    TransactionDB.instance.updateTransactionToDB(_model, widget.datas.id!);
    TransactionDB.instance.refresh();
    Navigator.of(context).pop();
  }
}
