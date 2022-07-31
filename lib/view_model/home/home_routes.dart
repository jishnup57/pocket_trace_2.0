import 'package:flutter/material.dart';

class HomeRoutes with ChangeNotifier{
int selectedIndex=0;
PageController pageController=PageController(initialPage: 0);
changeIndex( int selectedIndex ){
 this.selectedIndex=selectedIndex;
}
}