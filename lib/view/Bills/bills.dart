import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/util/constants.dart';
import 'package:one/view/Bills/widget/bill_text_field.dart';
import 'package:one/view_model/bill/billdb.dart';
import 'package:provider/provider.dart';

class ScreenBills extends StatefulWidget {
  const ScreenBills({Key? key}) : super(key: key);

  @override
  State<ScreenBills> createState() => _ScreenBillsState();
}

class _ScreenBillsState extends State<ScreenBills> {
  DateTime? _selectedDate;
  final titlecontroller = TextEditingController();
  final amountController = TextEditingController();
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
          ),
        ),
        toolbarHeight: 100,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: width / 1.5, top: height / 75),
          child: SvgPicture.asset(
            'asset/images/bills.svg',
            width: width / 2.5,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: height / 25),
          child: const Text('Add Bills', textScaleFactor: 1.5),
        ),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15),
        child: Container(
          height: height / 1.4,
          width: width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 210, 208, 202),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Date :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: width / 10, left: width / 12),
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
                        final _selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30 * 6),
                          ),
                        );
                        if (_selectedDateTemp == null) {
                          return;
                        } else {
                          setState(() {
                            _selectedDate = _selectedDateTemp;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        size: height / 25,
                        color: Colors.black54,
                      ),
                      label: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : DateFormat('MMMMd').format(_selectedDate!),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BillTextField(
                  titlecontroller: titlecontroller,
                  title: 'Title',),
              const SizedBox(
                height: 20,
              ),
              BillTextField(titlecontroller: amountController, title: 'Amount',keyType: TextInputType.number),
              kHight100,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 12,
                    width: width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        addbills(context);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          primary: kBlueColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addbills(BuildContext ctx) async {
    final _title = titlecontroller.text.trim();
    final _amount = amountController.text.trim();
    if (_amount.isEmpty) {
      return;
    }
    if (_title.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }

    final _model = BillModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _title,
      date: _selectedDate!,
      amound: _amount,
    );
    context.read<BillDB>().insertbill(_model);
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.black,
        content: Text('Bill added successfully...'),
      ),
    );
    titlecontroller.clear();
    amountController.clear();
    _selectedDate == null;
  }
}

