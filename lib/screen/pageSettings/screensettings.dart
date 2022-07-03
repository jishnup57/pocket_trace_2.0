import 'package:flutter/material.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/functions/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Settings extends StatelessWidget {
   Settings({Key? key}) : super(key: key);
   final _setvaluecontroller=TextEditingController();
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
         // toolbarHeight: height/8,
          title: const Text('Settings', textScaleFactor: 1.3),
          backgroundColor: appcolor.buttonBlue,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8,top:20),
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
                  height: 80,
                ),
                const Center(
                  child: Text(
                   'Set Dialy Limit',
                   style:
                       TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   
                    Container(
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
                            controller:_setvaluecontroller ,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Enter the Limit',
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
                const SizedBox(
                  height: 50,
                ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 15,
                      width: width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          setupDiallyLimit(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            primary: appcolor.buttonBlue),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
  Future<void>setupDiallyLimit(BuildContext context)async{
    final _setamound=_setvaluecontroller.text.trim();
    if (_setamound.isEmpty) {
      return;
    }
    final convertedSetAmound=double.tryParse(_setamound);
    if (convertedSetAmound==null) {
      return;
    }
    final sharedpre=await SharedPreferences.getInstance();
    await sharedpre.setDouble('Dialylimit',convertedSetAmound);
    Functions().getSetamount();
    Navigator.of(context).pop();
  }
    
}
