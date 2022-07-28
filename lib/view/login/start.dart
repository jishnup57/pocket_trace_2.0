

import 'package:flutter/material.dart';
import 'package:one/color/app_colors.dart' as appcolor;
import 'package:one/main.dart';
import 'package:one/view/Homepage/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
String username='';
class StartScreen extends StatelessWidget {
   StartScreen({Key? key}) : super(key: key);
      final _nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: height / 2,
            child:Image.asset('asset/applogo/pocket_logo.jpg')
          ),
          const Text('What should we call you?..',
          textScaleFactor: 1.7,
          style:TextStyle(
            color: Color(0xff002c41),
            fontWeight: FontWeight.w600
          )
          ,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: appcolor.buttonBlue,
                      ),
                      hintText: 'Username',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appcolor.buttonBlue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: appcolor.buttonBlue, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  SizedBox(
                   // width: width / 2,
                    height: height / 13,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(height / 50),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(appcolor.buttonBlue)),
                      onPressed: () {
                        setLogedIn(context);
                      },
                      child:const Text(
                        'START',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future <void> setLogedIn(BuildContext context)async{
     username= _nameController.text.trim();
    // ignore: unnecessary_null_comparison
    if(username==null){
      return;
    }else{
      final _sharedprefs = await SharedPreferences.getInstance();
      await _sharedprefs.setBool(loginKey, true);
      Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => MainScreen()));
    }
  }
}
