import 'package:flutter/material.dart';
import 'nurse.dart';
import 'doctor.dart';
import 'board.dart';
import 'report_page.dart'; // 월간 환자 상태 보고서 페이지를 위한 새로운 파일

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따른 아이콘 크기와 컨테이너 크기 설정
    double iconSize = MediaQuery.of(context).size.width * 0.15;
    double containerHeight = MediaQuery.of(context).size.height * 0.2; // 컨테이너 높이
    double containerWidth = MediaQuery.of(context).size.width * 0.8; // 컨테이너 너비
    double fontSize = MediaQuery.of(context).size.width * 0.05; // 폰트 크기 동적 설정

    return Scaffold(
      appBar: AppBar(
        title: Text('공지 사항', style: TextStyle(fontSize: 28)),
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 수정
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildServiceIconsSection(context, iconSize, fontSize),
              SizedBox(height: 30), // 아이콘 섹션과 보고서 버튼 사이의 간격
              _buildReportButton(context, fontSize),
              SizedBox(height: 20), // 버튼과 요약문 사이의 간격
              _buildReportSummary(), // 요약문 표시
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIconsSection(BuildContext context, double iconSize, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildServiceIcon(context, '의사', Icons.local_hospital, Colors.blue, 1, iconSize, fontSize),
          _buildServiceIcon(context, '간호사', Icons.healing, Colors.green, 5, iconSize, fontSize),
          _buildServiceIcon(context, '공지사항', Icons.description, Colors.orange, 2, iconSize, fontSize),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(BuildContext context, String label, IconData icon, Color color, int notificationCount, double iconSize, double fontSize) {
    return GestureDetector(
      onTap: () {
        if (label == '의사') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorPage()),
          );
        } else if (label == '간호사') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NursePage()),
          );
        } else if (label == '공지사항') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardPage()),
          );
        }
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(iconSize * 0.7),
                ),
                child: Icon(
                  icon,
                  size: iconSize * 0.7,
                  color: color,
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  top: -iconSize * 0.05,
                  right: -iconSize * 0.05,
                  child: Container(
                    width: iconSize * 0.3, // Badge width
                    height: iconSize * 0.3, // Badge height
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        notificationCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: iconSize * 0.2, // Dynamic font size relative to the icon size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5), // 텍스트와 아이콘 사이의 간격 줄임
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton(BuildContext context, double fontSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportPage()), // 보고서 페이지로 이동
        );
      },
      child: Text(
        '월간 환자 상태 보고서',
        style: TextStyle(fontSize: fontSize),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildReportSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        '이름: 이성식 (55세 / 남자)\n'
            '입원일: 2023년8월20일\n'
            '병실번호: 503호\n'
            '담당의사: 김철수\n'
            '기간: 2024년 7월\n\n'
            '상태요약: 현재 아버님 상태는 입원 당시 전립선 비대증과 전립선암, 뇌경색, 고혈압, 강직성 편마비, 인지기능 저하, 보행 장애가 있으셨는데요. '
            '지금 현재는 식사 잘하시고, 병원에서 해드릴 수 있는 보존적 치료를 하고 계십니다. 보존적 치료를 하면서 증상에 맞춰서 치료를 진행하고 있는데, '
            '약물 치료, 재활 치료, 지능력 향상 치료를 진행하고 있습니다. 현재 혈압이나 맥박, 체온은 다 정상이시고, 다른 이상 증상은 없으십니다. '
            '지금 현재 의료진의 재활 치료와 약물 치료를 잘 받고 계십니다.\n',
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}