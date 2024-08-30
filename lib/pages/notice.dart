import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice Page'),
      ),
      body: Center(
        child: Text('Notice Content'),
      ),
    );
  }
}