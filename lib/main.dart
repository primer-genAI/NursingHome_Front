import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '효도AI',
      debugShowCheckedModeBanner: false,
      home: MainLayout(),

    );
  }
}