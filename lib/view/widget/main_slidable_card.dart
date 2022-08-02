import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/view/screen_edit/edit.dart';
import 'package:one/view/widget/delete_popup.dart';
import 'package:provider/provider.dart';

import '../../view_model/edit/edit_trans.dart';

class MainSlidableCard extends StatelessWidget {
  const MainSlidableCard({Key? key, required this.value}) : super(key: key);
  final TransationModel value;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(value.id!),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) {
              showDeletePopUp(context, transactionid: value.id);
            },
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<EditTrans>().setDate(value.date);
              context.read<EditTrans>().setCategoryType(value.type);
               context.read<EditTrans>().setCategoryModel(value.category);
                context.read<EditTrans>().setcategotyid(null);           
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => EditScreen(datas: value)));
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
              height: 60,
              width: 80,
              decoration: BoxDecoration(
                  color: const Color(0xff212236),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    parseDateMonth(value.date),
                    textScaleFactor: 1.5,
                    style: const TextStyle(
                        fontFamily: 'styleDate', color: Colors.white),
                  ),
                  Text(
                    parseDate(value.date),
                    textScaleFactor: 1.3,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'styleDate'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.category.name,
                      textScaleFactor: 1.6,
                      style: const TextStyle(
                          color: Color.fromARGB(243, 6, 46, 81),
                          fontFamily: 'CourrierPrime',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(value.notes,
                        textScaleFactor: 1.2,
                        style: const TextStyle(
                          color: Color.fromARGB(243, 6, 46, 81),
                          fontFamily: 'Lato',
                        ))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                value.type == CategoryType.income
                    ? mainCardAmountText(const Color.fromARGB(255, 4, 106, 9))
                    : mainCardAmountText(const Color.fromARGB(255, 200, 6, 6))
              ],
            )
          ],
        ),
      ),
    );
  }

  Text mainCardAmountText(Color color) {
    return Text('₹${value.amound.toInt().toString()}',
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontFamily: 'styleNum', color:color ));
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
}