import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view_model/bill/billdb.dart';
import 'package:provider/provider.dart';

class ShowBill extends StatelessWidget {
  const ShowBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reminder',
            textScaleFactor: 1.2,
          ),
          backgroundColor: kBlueColor,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(15, 15),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<BillDB>(
            builder: (context, value, _) {
              return value.allBillList.isEmpty?
               const Center(child: Text("Add Some Bills",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent
               ),),):
               ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final _value = value.allBillList[index];
                  return Container(
                    height: height / 3.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 210, 208, 202),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        BillDeleteButton(width: width, value: _value),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                _value.amound,
                                textScaleFactor: 1.5,
                              ),
                              Text(
                                _value.title,
                                textScaleFactor: 1.5,
                              ),
                              Text(
                                DateFormat('MMMMd').format(_value.date),
                                textScaleFactor: 1.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
                itemCount: value.allBillList.length,
              );
            },
          ),
        ));
  }
}

class BillDeleteButton extends StatelessWidget {
  const BillDeleteButton({
    Key? key,
    required this.width,
    required BillModel value,
  })  : _value = value,
        super(key: key);

  final double width;
  final BillModel _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width / 10,
          height: width / 10,
          child: ColoredBox(
            color: Colors.red,
            child: IconButton(
              onPressed: () {
                Provider.of<BillDB>(context, listen: false)
                    .deleteBill(_value.id);
              },
              color: Colors.white,
              icon: Icon(
                Icons.close,
                size: width / 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
