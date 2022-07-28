import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one/view/Statics/piechart.dart';
import 'package:one/view/widget/empty_graph_show.dart';
import 'package:one/view_model/category/CircularProgress/functions/chartfunction.dart';
import 'package:one/view_model/category/category_db.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:one/color/app_colors.dart' as appcolor;



class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  String choice = TransactionDB.instance.incomListNotifier.value.isNotEmpty?'Income':'Expense';
  List<ChartData> data = chartLogic(
      TransactionDB.instance.incomListNotifier.value.isNotEmpty
          ? TransactionDB.instance.incomListNotifier.value
          : TransactionDB.instance.expenceListNotifier.value);
  @override
  void initState() {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(25, 25),
          ),
        ),
        toolbarHeight: height/8,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: width / 1.7, top: height / 75),
          child: SvgPicture.asset(
            'asset/images/Statics.svg',
            width: width / 2.5,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: height / 25),
          child: const Text('Statitics', textScaleFactor: 1.5),
        ),
        backgroundColor: appcolor.buttonBlue,
        centerTitle: true,
      ),
      body:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text(
                        'Income',
                        style: TextStyle(
                          color: (choice == 'Income')
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selectedColor: Colors.green,
                      selected: choice == 'Income' ? true : false,
                      onSelected: (bool value) {
                        setState(() {
                          choice = 'Income';
                          data = chartLogic(
                              TransactionDB.instance.incomListNotifier.value);
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
                          color: (choice == 'Expense')
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selectedColor: Colors.red,
                      selected: choice == 'Expense' ? true : false,
                      onSelected: (bool value) {
                        setState(() {
                          choice = 'Expense';
                          data = chartLogic(
                              TransactionDB.instance.expenceListNotifier.value);
                        });
                      },
                    ),
                     const SizedBox(
                      width: 5,
                    ),
                      ChoiceChip(
                      label: Text(
                        'OverAll',
                        style: TextStyle(
                          color: (choice == 'OverAll')
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selectedColor: Colors.black,
                      selected: choice == 'OverAll' ? true : false,
                      onSelected: (bool value) {
                        setState(() {
                          choice = 'OverAll';
                        });
                       //overAllChart();
                      },
                    )
                  ],
                ),data.isEmpty
          ? emptyGraphBackground(context)
          :choice=='OverAll'? overAllChart():
                SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      dataSource: data,
                      xValueMapper: (ChartData datas, _) => datas.categories,
                      yValueMapper: (ChartData datas, _) => datas.amount,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
