import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Page'),
      ),
      body: Center(
        child: Text('Doctor Content'),
      ),
    );
  }
}