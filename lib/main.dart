import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'pages/home_page.dart';
import 'global_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
        onLogin: (userInfo) {
          GlobalState.userInfo = userInfo;
          GlobalState.isLoggedIn = true;
          runApp(MyAppWithLayout());
        },
      ),
    );
  }
}

class MyAppWithLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainLayout(),
    );
  }
}