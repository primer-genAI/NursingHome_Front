import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onLogin;

  HomePage({required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'), // Ensure this path is correct
              SizedBox(height: 20),
              Text(
                '환자안심케어 요양병원 AI',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('실시간 요양병원 환자 정보 손쉽게 확인하세요', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: '사용자명',
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onLogin, // 로그인 버튼을 누르면 PatientInfoPage로 이동
                child: Text('로그인', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}