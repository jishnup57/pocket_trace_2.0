import 'package:flutter/material.dart';
import 'package:one/view/pageSettings/screensettings.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/view/widget/resetpopup.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text(
              'My profile',
              style: TextStyle(fontSize: 20),
            ),
            leading:const Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: appcolor.buttonBlue,
            ),
            onTap: () {},
          ),
           ListTile(
            title: const Text(
              'Set Dialy Limit',
              style: TextStyle(fontSize: 20),
            ),
            leading:const Icon(
              Icons.hourglass_top_rounded,
              size: 30,
              color: appcolor.buttonBlue,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Settings()));
            },
          ), 
           ListTile(
            title: const Text(
              'Reset Data',
              style: TextStyle(fontSize: 20),
            ),
            leading:const Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: appcolor.buttonBlue,
            ),
            onTap: () {
             showDialog(context: context, builder:(ctx){
              return  dialogShow(ctx);
             });
            },
          ),
        ],
      ),
    );
  }
}
