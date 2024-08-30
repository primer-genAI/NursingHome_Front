import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따른 아이콘 크기와 컨테이너 크기 설정
    double iconSize = MediaQuery.of(context).size.width * 0.15;
    double containerHeight = MediaQuery.of(context).size.height * 0.2; // 컨테이너 높이
    double containerWidth = MediaQuery.of(context).size.width * 0.8;  // 컨테이너 너비
    double fontSize = MediaQuery.of(context).size.width * 0.05; // 폰트 크기 동적 설정

    return Scaffold(
      appBar: AppBar(
        title: Text('공지 사항', style: TextStyle(fontSize: 28)),
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 수정
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildServiceIconsSection(context, iconSize, containerWidth, containerHeight, fontSize),
        ),
      ),
    );
  }

  Widget _buildServiceIconsSection(BuildContext context, double iconSize, double containerWidth, double containerHeight, double fontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildServiceIcon(context, '의사', 'assets/images/doctor_icon.png', 1, iconSize, containerWidth, containerHeight, fontSize),
        SizedBox(height: 16),
        _buildServiceIcon(context, '간호사', 'assets/images/nurse_icon.png', 5, iconSize, containerWidth, containerHeight, fontSize),
        SizedBox(height: 16),
        _buildServiceIcon(context, '행정 안내', 'assets/images/document_icon.png', 2, iconSize, containerWidth, containerHeight, fontSize),
      ],
    );
  }


  Widget _buildServiceIcon(BuildContext context, String label, String imagePath, int notificationCount, double iconSize, double containerWidth, double containerHeight, double fontSize) {
    return Center(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center( // 이미지를 중앙에 배치하기 위해 Center 위젯 사용
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(imagePath, width: iconSize, height: iconSize),
                  SizedBox(height: 10),
                  Text(
                    label,
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: -5,
            //   right: -5,
            //   child: Container(
            //     padding: EdgeInsets.all(6.0),
            //     decoration: BoxDecoration(
            //       color: Colors.red,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Text(
            //       notificationCount.toString(),
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}