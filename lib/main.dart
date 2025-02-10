import 'package:collectics/features/home/home.dart';
import 'package:collectics/features/login/login.dart';
import 'package:collectics/features/store/store_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}