import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/widget/empty_list_show.dart';
import 'package:one/view/widget/main_slidable_card.dart';
import 'package:one/view_model/all_transactions/controller_all_trans.dart';
import 'package:provider/provider.dart';

class AllTransactions extends StatelessWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions', textScaleFactor: 1.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(25, 25),
          ),
        ),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<AllTransCtrl>(
            builder: (context, value, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectedChip(
                        obj: value,
                        title: 'All',
                        selectedColor: Colors.black,
                      ),
                      SelectedChip(
                        obj: value,
                        title: 'Income',
                        selectedColor: Colors.green,
                      ),
                      SelectedChip(
                        obj: value,
                        title: 'Expense',
                        selectedColor: Colors.red,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: value.drodownName,
                        items: value.items
                            .map<DropdownMenuItem<String>>((String drpvalue) {
                          return DropdownMenuItem(
                            child: Text(drpvalue),
                            value: drpvalue,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          value.dropdownButtonRebuild(newValue);
                        },
                      ),
                      Visibility(
                        visible: value.drodownName == 'Monthly' ? true : false,
                        child: TextButton.icon(onPressed: (){
                          value.pickMonth(context);
                        }, label: Text(DateFormat('MMMM').format(value.pickedmonth)),
                        icon: const Icon(Icons.calendar_month),),
                      )
                    ],
                  ),
                  Visibility(
                    visible: value.drodownName == 'Coustom'? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          TextButton.icon(onPressed: (){
                            value.pickFirstDate(context);
                          }, label: Text(DateFormat('yMMMd').format(value.firstdate)),
                          icon: const Icon(Icons.calendar_month),),
                          const Icon(Icons.sync_alt),
                           TextButton.icon(onPressed: (){
                            value.pickLastDate(context);
                          }, label: Text(DateFormat('yMMMd').format(value.lastdate)),
                          icon: const Icon(Icons.calendar_month),),
                          
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          Expanded(
            child: Consumer<AllTransCtrl>(
              builder:(context, value, child) =>value.filterdList.isEmpty?
              Column(
                        children: [
                          SizedBox(height: height/9,),
                          emptyListBackground(context),
                        ],
                      )
                      : 
               ListView.separated(itemBuilder: (ctx,i){
                final newval=value.filterdList[i];
                return MainSlidableCard(value: newval);
              }, separatorBuilder:((context, index) => const SizedBox(height: 10,)) ,
               itemCount: value.filterdList.length) ),
          ),
        ],
      ),
    );
  }
}

class SelectedChip extends StatelessWidget {
  const SelectedChip(
      {Key? key,
      required this.obj,
      required this.title,
      required this.selectedColor})
      : super(key: key);
  final AllTransCtrl obj;
  final String title;
  final Color selectedColor;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        title == 'All' ? '    $title..   ' : title,
        style: TextStyle(
          color: (obj.choice == title) ? Colors.white : Colors.black,
        ),
      ),
      selected: obj.choice == title ? true : false,
      selectedColor: selectedColor,
      onSelected: (val) {
        obj.choiceChipRebuild(title);
      },
    );
  }
}
