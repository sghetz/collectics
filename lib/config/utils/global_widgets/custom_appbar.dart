import 'package:collectics/config/utils/theme/theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 final GlobalKey<ScaffoldState> scaffoldKey;
 
 const CustomAppBar({
   super.key,
   required this.scaffoldKey,
 });

 @override
 Widget build(BuildContext context) {
   return AppBar(
     backgroundColor: AppColors.background,
     elevation: 0,
     leading: IconButton(
       icon: const Icon(Icons.person_outline, color: AppColors.charcoal),
       onPressed: () {},
     ),
     title: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SvgPicture.asset(
          'assets/icons/currency.svg',  // Path to your custom SVG icon
          color: AppColors.primary,            // Optional: Color if you want to apply it to your SVG
          width: 24,                           // Optional: Define width
          height: 24,                          // Optional: Define height
        ),
         const SizedBox(width: 4),
         const Text(
           '2,500',
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
           ),
         ),
         const SizedBox(width: 12),
         SvgPicture.asset(
          'assets/icons/clock.svg',  // Path to your custom SVG icon
          color: AppColors.charcoal,            // Optional: Color if you want to apply it to your SVG
          width: 24,                           // Optional: Define width
          height: 24,                          // Optional: Define height
        ),
         const SizedBox(width: 4),
         const Text(
           '1/1',
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
           ),
         ),
       ],
     ),
     actions: [
       IconButton(
         icon: const Icon(Icons.menu, color: Colors.black),
         onPressed: () {
           scaffoldKey.currentState?.openEndDrawer();
         },
       ),
     ],
     centerTitle: true,
   );
 }

 @override
 Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}