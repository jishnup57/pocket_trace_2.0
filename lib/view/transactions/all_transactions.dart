import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/screen_edit/edit.dart';
import 'package:one/view/widget/delete_popup.dart';
import 'package:one/view/widget/empty_list_show.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:one/view_model/transaction/transaction_db.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

//ValueNotifier<bool> visibleMonth = ValueNotifier(false);
DateTime selectedMonth = DateTime.now();

class _AllTransactionsState extends State<AllTransactions> {
  ValueNotifier<List<TransationModel>> selectedlist =
      TransactionDB.instance.transactionListNotifier;
  String choice = 'All';
  String dropDownValue = 'All';
  DateTime? _selectedCustomDateFirst;
  DateTime? _selectedCustomDateLast;

  @override
  void initState() {
    TransactionDB.instance.filtration(selectedlist.value);
    updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    List<String> items = [
      'All',
      'Today',
      'Yesterday',
      'Monthly',
      'Custom'
    ];
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
          child: const Text('Transactions', textScaleFactor: 1.5),
        ),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text(
                  '    All..   ',
                  style: TextStyle(
                    color: (choice == 'All') ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.black,
                selected: choice == 'All' ? true : false,
                onSelected: (bool value) {
                  setState(() {
                    choice = 'All';
                    selectedlist =
                        TransactionDB.instance.transactionListNotifier;
                    TransactionDB.instance.filtration(selectedlist.value);
                    updateData();
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              ChoiceChip(
                label: Text(
                  'Income',
                  style: TextStyle(
                    color: (choice == 'Income') ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.green,
                selected: choice == 'Income' ? true : false,
                onSelected: (bool value) {
                  setState(() {
                    choice = 'Income';
                    selectedlist = TransactionDB.instance.incomListNotifier;
                    TransactionDB.instance.filtration(selectedlist.value);
                    updateData();
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              ChoiceChip(
                label: Text(
                  'Expense',
                  style: TextStyle(
                    color: (choice == 'Expense') ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.red,
                selected: choice == 'Expense' ? true : false,
                onSelected: (bool value) {
                  setState(() {
                    choice = 'Expense';
                    selectedlist = TransactionDB.instance.expenceListNotifier;
                    TransactionDB.instance.filtration(selectedlist.value);
                    updateData();
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: dropDownValue,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
              ),
              // ValueListenableBuilder(
              //     valueListenable: visibleMonth,
              //     builder: (BuildContext ctx, bool _newBool, Widget? _) {
              //       return Visibility(
              //           visible: _newBool,
              //           child: TextButton(
              //               onPressed: () {
              //                 pickDate();
              //               },
              //               child: Text(
              //                   DateFormat('MMMM').format(selectedMonth))));
              //     }),
              Visibility(
                visible: dropDownValue == 'Monthly' ? true : false,
                child: TextButton(
                    onPressed: () {
                      pickDate();
                    },
                    child: Text(DateFormat('MMMM').format(selectedMonth))),
              )
            ],
          ),
          Visibility(
            visible: dropDownValue == 'Custom' ? true : false,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton.icon(
                onPressed: () async {
                  final _tempdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365 * 5)),
                    lastDate: DateTime.now(),
                  );
                  if (_tempdate == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedCustomDateFirst = _tempdate;
                    });
                    if (_selectedCustomDateFirst != null &&
                        _selectedCustomDateLast != null) {
                      TransactionDB.instance.customFiltration(
                          selectedlist: selectedlist.value,
                          firstDate: _selectedCustomDateFirst!,
                          lastDate: _selectedCustomDateLast!);
                    }
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(_selectedCustomDateFirst == null
                    ? 'First date'
                    : DateFormat('yMMMd').format(_selectedCustomDateFirst!)),
              ),
              const Icon(Icons.sync_alt),
              TextButton.icon(
                onPressed: () async {
                  final _tempdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: _selectedCustomDateFirst ?? DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                  if (_tempdate == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedCustomDateLast = _tempdate;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(_selectedCustomDateLast == null
                    ? 'Last date'
                    : DateFormat('yMMMd').format(_selectedCustomDateLast!)),
              ),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: valueChecking(context),
                builder: (BuildContext ctx, List<TransationModel> newList,
                    Widget? _) {
                  return selectedlist.value.isEmpty
                      ? Column(
                        children: [
                          SizedBox(height: height/9,),
                          emptyListBackground(context),
                        ],
                      )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: newList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final _value = newList[index];
                            return Slidable(
                              key: Key(_value.id!),
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx) {
                                      showDeletePopUp(context,
                                          transactionid: _value.id);
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: const Color(0xFFFE4A49),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  EditScreen(datas: _value)));
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.green[800],
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              child: Card(
                                color: Colors.white70,
                                elevation: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 6, top: 6, bottom: 6),
                                      height: 60,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff212236),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            parseDateMonth(_value.date),
                                            textScaleFactor: 1.5,
                                            style: const TextStyle(
                                                fontFamily: 'styleDate',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            parseDate(_value.date),
                                            textScaleFactor: 1.3,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'styleDate'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                _value.category.name,
                                                textScaleFactor: 1.6,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        243, 6, 46, 81),
                                                    fontFamily: 'CourrierPrime',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Text(_value.notes,
                                                textScaleFactor: 1.2,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      243, 6, 46, 81),
                                                  fontFamily: 'Lato',
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _value.type == CategoryType.income
                                            ? Text(
                                                '₹${_value.amound.toInt().toString()}',
                                                textScaleFactor: 1.8,
                                                style: TextStyle(
                                                    fontFamily: 'styleNum',
                                                    color: Colors.green[800]))
                                            : Text(
                                                '₹${_value.amound.toInt().toString()}',
                                                textScaleFactor: 1.8,
                                                style: TextStyle(
                                                    fontFamily: 'styleNum',
                                                    color: Colors.red[900]))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String parseDateMonth(DateTime date) {
    final _date = DateFormat().add_MMMd().format(date);
    final _splitdate = _date.split(' ');
    return _splitdate.first;
  }

  String parseDate(DateTime date) {
    final _date = DateFormat().add_MMMd().format(date);
    final _splitdate = _date.split(' ');
    return _splitdate.last;
  }

  ValueNotifier<List<TransationModel>> valueChecking(context) {
    // visibleMonth.value=false;
    //'All','Today','Yesterday','Monthly','Yearly'
    // visibleMonth.value = false;
    if (dropDownValue == 'Today') {
      return TransactionDB.instance.todayListNotifier;
    }
    if (dropDownValue == 'Yesterday') {
      return TransactionDB.instance.yesterdayListNotifier;
    }
    if (dropDownValue == 'Monthly') {
      // visibleMonth.value = true;
      return TransactionDB.instance.monthelyListNotifier;
    }
    if (dropDownValue == 'Custom') {
      TransactionDB.instance.customFiltration(selectedlist: selectedlist.value, firstDate: _selectedCustomDateFirst??DateTime.now(), lastDate:_selectedCustomDateLast??DateTime.now());
      return TransactionDB.instance.customListNotifier;
    }


    return selectedlist;
  }

  pickDate() async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate:DateTime(2020) ,
      lastDate:DateTime.now() ,
    );
    setState(() {
      selectedMonth = selected ?? DateTime.now();
    });
    TransactionDB.instance.monthelyListNotifier.value.clear();
    updateData();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    TransactionDB.instance.monthelyListNotifier.notifyListeners();
  }

  updateData() async {
    Future.forEach(selectedlist.value, (TransationModel model) {
      if (model.date.month == selectedMonth.month &&
          model.date.year == selectedMonth.year) {
        TransactionDB.instance.monthelyListNotifier.value.add(model);
      }
    });
  }
}
