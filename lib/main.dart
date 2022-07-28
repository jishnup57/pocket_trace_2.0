import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/view/splashscreen/splash.dart';
import 'db/category/category_db.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/services.dart';


const loginKey='UserLogedIn';


void main() async{
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
    if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransationModelAdapter().typeId)){
    Hive.registerAdapter(TransationModelAdapter());
  }
  if(!Hive.isAdapterRegistered(BillModelAdapter().typeId)){
    Hive.registerAdapter(BillModelAdapter());
  }
  CategoryDB().refreshUI();
  //TransactionDB.instance.refresh();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates:const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Schyler'),
     home:const SplashScreen(),
  
   
    );
  }
}
