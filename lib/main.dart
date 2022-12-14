import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:one/Model/Transaction/transaction_model.dart';
import 'package:one/Model/bill/bill_model.dart';
import 'package:one/Model/category/category_model.dart';
import 'package:one/view/splashscreen/splash.dart';
import 'package:one/view_model/addTrans/add_transaction.dart';
import 'package:one/view_model/all_transactions/controller_all_trans.dart';
import 'package:one/view_model/bill/billdb.dart';
import 'package:one/view_model/category/CircularProgress/functions/functions.dart';
import 'package:one/view_model/edit/edit_trans.dart';
import 'package:one/view_model/home/home_routes.dart';
import 'package:one/view_model/statics/statics_model.dart';
import 'package:one/view_model/transaction/transaction_db.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/services.dart';
import 'view_model/category/category_db.dart';

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransationModelAdapter().typeId)) {
    Hive.registerAdapter(TransationModelAdapter());
  }
  if (!Hive.isAdapterRegistered(BillModelAdapter().typeId)) {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BillDB(),),
        ChangeNotifierProvider(create: (context) => CategoryDB(),),
        ChangeNotifierProvider(create: (context) => TransactionDB(),),
        ChangeNotifierProvider(create: (context) => AllTransCtrl(),),
        ChangeNotifierProvider(create: (context) => HomeRoutes(),),
        ChangeNotifierProvider(create: (context) => AddTrans(),),
        ChangeNotifierProvider(create: (context) => Statics(),),
        ChangeNotifierProvider(create: (context) => EditTrans(),),
        ChangeNotifierProvider(create: (context) => Functions(),)


      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'Schyler'),
        home: const SplashScreen(),
      ),
    );
  }
}
