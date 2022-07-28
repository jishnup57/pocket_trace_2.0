import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/db/bill/billdb.dart';


class ShowBill extends StatefulWidget {
  const ShowBill({Key? key}) : super(key: key);

  @override
  State<ShowBill> createState() => _ShowBillState();
}

class _ShowBillState extends State<ShowBill> {
  @override
  Widget build(BuildContext context) {
    BillDB().refreshBillUI();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        title:const Text('Reminder',
        textScaleFactor: 1.2,),
        backgroundColor: appcolor.buttonBlue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(15, 15),
          ),
        ),
      ),
      //  AppBar(
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.elliptical(25, 25),
      //     ),
      //   ),
      //   toolbarHeight: 100,
      //   title: Padding(
      //     padding: EdgeInsets.only(top: height / 25),
      //     child: const Text('Reminder', textScaleFactor: 1.5),
      //   ),
      //   backgroundColor: appcolor.buttonBlue,
      //   centerTitle: true,
      // ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ValueListenableBuilder(
            valueListenable: BillDB.instance.billListLisener,
            builder: (BuildContext ctx, List<BillModel> newList, Widget? _) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final _value = newList[index];
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
                             Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                   SizedBox(
                        width: width/10,
                        height: width/10,
                        child: ColoredBox(
                        color: Colors.red,
                        child: IconButton( onPressed: () {
                               // BillDB.instance.deleteBill(_value.id);
                              },
                              color: Colors.white,
                              icon: Icon(
                                Icons.close,
                                size: width/20,
                              ),
                        ),
                        ),
                        ),
                              ],
                        ),
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
                itemCount: newList.length,
              );
            },
          )),
    );
  }
}
