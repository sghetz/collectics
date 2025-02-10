// main_scaffold.dart
import 'package:collectics/config/utils/global_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'side_menu.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  const MainScaffold({super.key, required this.body});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      endDrawer: const SideMenu(),
      body: widget.body,
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}