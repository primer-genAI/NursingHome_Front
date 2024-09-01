import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/ai_nurse.dart';
import 'pages/notice.dart';
import 'pages/patient_info_page.dart';
import 'widgets/custom_nav_bar.dart';
import 'global_state.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {


  // int _selectedIndex = 1; // 기본 홈 페이지를 선택
  // bool isLoggedIn = false; // 로그인 상태를 관리
  //
  final PageController _pageController = PageController(initialPage: 1);
  Map<String, dynamic>? userInfo; // 로그인 후 사용자 정보를 저장

  void _onItemTapped(int index) {
    setState(() {
      GlobalState.selectedIndex = index; // 전역 페이지 업데이트
    });
    _pageController.jumpToPage(index);
  }

  void navigateToPatientInfoPage(Map<String, dynamic> info) {
    setState(() {
      GlobalState.isLoggedIn = true; // 로그인 상태를 true로 변경
      GlobalState.userInfo = info; // 사용자 정보를 저장

      GlobalState.selectedIndex = 1; // PatientInfoPage로 인덱스를 변경
    });
    _pageController.jumpToPage(1); // 페이지를 Home에서 PatientInfo로 변경
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            GlobalState.selectedIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), // 스와이프 비활성화
        children: <Widget>[
          AINursePage(), // AI Nurse Page
          GlobalState.isLoggedIn
              ? PatientInfoPage(userInfo: GlobalState.userInfo ?? {})
              : HomePage(onLogin: navigateToPatientInfoPage), // 로그인 상태에 따라 페이지 변경
          NoticePage(), // Notice Page
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: GlobalState.selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}