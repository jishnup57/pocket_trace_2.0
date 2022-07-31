

// import 'package:flutter/material.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// class BottomWaterdropNavBar extends StatelessWidget {
//   const BottomWaterdropNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WaterDropNavBar(
//           backgroundColor: navigationBarColor,
//           onItemSelected: (int index) {
//             setState(() {
//               selectedIndex = index;
//             });
//             pageController.animateToPage(selectedIndex,
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.easeOutQuad);
//           },
//           selectedIndex: selectedIndex,
//           barItems: <BarItem>[
//             BarItem(
//               filledIcon: Icons.bookmark_rounded,
//               outlinedIcon: Icons.bookmark_border_rounded,
//             ),
//             BarItem(
//                 filledIcon: Icons.favorite_rounded,
//                 outlinedIcon: Icons.favorite_border_rounded),
//             BarItem(
//               filledIcon: Icons.email_rounded,
//               outlinedIcon: Icons.email_outlined,
//             ),
//             BarItem(
//               filledIcon: Icons.folder_rounded,
//               outlinedIcon: Icons.folder_outlined,
//             ),
//           ],
//         );
//   }
// }