import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/ai_nurse.dart';
import 'pages/notice.dart';
import 'pages/patient_info_page.dart';
import 'widgets/custom_nav_bar.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1; // 기본 홈 페이지를 선택
  final PageController _pageController = PageController(initialPage: 1);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void navigateToPatientInfoPage() {
    setState(() {
      _selectedIndex = 3; // PatientInfoPage로 인덱스를 변경
    });
    _pageController.jumpToPage(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          AINursePage(),    // AI Nurse Page
          HomePage(onLogin: navigateToPatientInfoPage), // Home Page에서 로그인이 되면 PatientInfoPage로 이동
          NoticePage(),     // Notice Page
          PatientInfoPage(), // Patient Info Page
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}