import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one/util/constants.dart';
import 'package:one/view/Homepage/home.dart';
import 'package:one/view/login/start.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   cheakUserLogedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       backgroundColor: const Color(0xfffefeff),
      body: SafeArea(
        child: Center(
         child: Image.asset('asset/applogo/pocket_trace_logo.jpg')
        ),
      ),
     
    );
  }
    Future<void> gotoLogin() async{
   await Future.delayed(const Duration(seconds: 3));
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>StartScreen()));
   
  }
  Future <void> cheakUserLogedIn()async{
    final _sharedprefe=await SharedPreferences.getInstance();
    final _userlogedin= _sharedprefe.getBool(loginKey);
     if (_userlogedin==null||_userlogedin==false) {
      gotoLogin();
    }else{
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1)=>const MainScreen()));
    }
  }
}
