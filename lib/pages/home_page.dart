import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'patient_info_page.dart'; // 다음 페이지를 위한 import

class HomePage extends StatefulWidget {
  final void Function(Map<String, dynamic>) onLogin;

  HomePage({required this.onLogin});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // 환자명 리스트
  final List<String> patientNames = [
    "남A",
    "남B",
    "남C",
    "여A",
    "여B",
    "여C",
  ];

  String? _selectedPatientName; // 선택된 환자명

  // 비밀번호 맵 (환자명에 따른 비밀번호 매핑)
  final Map<String, String> patientPasswords = {
    "남A": "password123",
    "남B": "password456",
    "남C": "password789",
    "여A": "password321",
    "여B": "password654",
    "여C": "password987",
  };

  // 로그인 API 호출 함수
  Future<void> _login() async {
    if (_selectedPatientName == null) {
      // 환자명을 선택하지 않은 경우 경고 메시지
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('환자명 선택'),
          content: Text('로그인할 환자명을 선택하세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
      return;
    }

    final String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://104.198.208.62:5001/login'),
        headers: {'Content-Type': 'application/json', 'accept':'application/json'},
        body: json.encode({
          'patient_id': _selectedPatientName,
        }),
      );

      if (response.statusCode == 200) {
        final userInfo = json.decode(response.body);

        // 로그인 성공 시, 사용자 정보를 다음 화면으로 전달
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientInfoPage(userInfo: userInfo),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('로그인 실패'),
            content: Text('사용자명이나 비밀번호가 올바르지 않습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('오류'),
          content: Text('로그인 중 오류가 발생했습니다. 네트워크 상태를 확인하세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

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
                '효도AI',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('실시간 요양병원 환자 정보 손쉽게 확인하세요', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              // DropdownButton을 사용하여 환자명을 선택
              DropdownButton<String>(
                hint: Text('사용자명을 선택하세요'),
                value: _selectedPatientName,
                items: patientNames.map((String name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPatientName = newValue;
                    // 환자명을 선택하면 해당하는 비밀번호를 비밀번호 필드에 자동 입력
                    passwordController.text = patientPasswords[newValue] ?? "";
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login, // 로그인 버튼을 누르면 API 호출
                child: Text('로그인', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}