import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';
import '../global_state.dart';
import 'ai_nurse.dart';
import 'chat_page.dart';
import 'notice.dart';
import 'help.dart';

class PatientInfoPage extends StatefulWidget {
  final Map<String, dynamic> userInfo;

  PatientInfoPage({required this.userInfo});

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  String selectedVitalSign = '혈압';
  String healthStatus = '양호';

  @override
  void initState() {
    super.initState();
    print(widget.userInfo); // 전달된 userInfo 데이터를 출력하여 확인
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('홈', style: TextStyle(fontSize: screenWidth * 0.07)),
        automaticallyImplyLeading: true, // 뒤로가기 버튼 자동 추가
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 추가
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // 전체 상태 섹션
            _buildPatientInfoSection(screenWidth, screenHeight),
            SizedBox(height: 35),
            // AI 상담사 선택하기 섹션
            _buildAINurseSelectSection(context, screenWidth),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: GlobalState.selectedIndex,
        onTap: (index) {
          setState(() {
            GlobalState.selectedIndex = index;
          });

          // 네비게이션 바의 선택에 따라 페이지 전환
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AINursePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PatientInfoPage(userInfo: widget.userInfo)),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NoticePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HelpPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildPatientInfoSection(double screenWidth, double screenHeight) {
    final String name = widget.userInfo['이름'] ?? '이름 없음';
    final String gender = widget.userInfo['성별'] ?? '성별 없음';
    final int age = widget.userInfo['나이'] ?? 0;
    final String admissionDate = widget.userInfo['입원일'] ?? '날짜 없음';
    final String roomNumber = widget.userInfo['병실번호'] ?? '병실 없음';
    final String roomInfo = widget.userInfo['병실정보'] ?? '병실 없음';
    final String doctor = widget.userInfo['담당의사'] ?? '담당의 없음';
    final String imgPath = widget.userInfo['image_path'] ?? 'No Image';

    final String imgUrl = 'http://104.198.208.62/static/$imgPath';

    final List<dynamic> diagList = widget.userInfo['질환명'] ?? [];
    final String diag = diagList.join(', ');

    double fontSize = screenWidth * 0.04;

    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '전체 상태: ',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildHealthStatusButton(fontSize),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight*0.005),
                    Text('◦ 이름: $name / $gender, ${age}세', style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: screenHeight*0.005),
                    Text('◦ 입원일: $admissionDate', style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: screenHeight*0.005),
                    Text('◦ 병실 번호: $roomNumber호($roomInfo)', style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: screenHeight*0.005),
                    Text('◦ 담당 의사: $doctor', style: TextStyle(fontSize: fontSize)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight*0.005),
          Text(
            '◦ 질환: $diag',
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: screenHeight*0.005),
          Text(
            '오늘의 상태 요약:',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight*0.005),
          Text('◦ 특이사항 없음', style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }

  Widget _buildHealthStatusButton(double fontSize) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          healthStatus = healthStatus == '양호' ? '위험' : '양호';
        });
      },
      child: Text(healthStatus, style: TextStyle(fontSize: fontSize)),
      style: ElevatedButton.styleFrom(
        backgroundColor: healthStatus == '양호' ? Colors.green : Colors.red,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 0.1, vertical: 0.1),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAINurseSelectSection(BuildContext context, double screenWidth) {
    double iconSize = screenWidth * 0.2;
    double fontSizeTitle = screenWidth * 0.07;
    double fontSizeSubtitle = screenWidth * 0.05;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'AI 상담사 선택하기',
          style: TextStyle(
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20, width: screenWidth),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 양쪽에 여백을 균등하게 분배
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage(nurseIdx: 1)),
                  );
                },
                child: _buildAIConsultantTile(
                  'AI 상담사 친절이',
                  'assets/images/nurse1.png',
                  '친절하고 자세하게 환자분의 상황을 설명해드리겠습니다.',
                  iconSize,
                  fontSizeSubtitle,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05), // 타일 사이에 여백 추가
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage(nurseIdx: 2)),
                  );
                },
                child: _buildAIConsultantTile(
                  'AI 상담사 간단이',
                  'assets/images/nurse2.png',
                  '전문적이고 요점만 간단히 환자분의 상황을 알려드립니다.',
                  iconSize,
                  fontSizeSubtitle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAIConsultantTile(String title, String imagePath, String subtitle, double iconSize, double fontSizeSubtitle) {
    return Column(
      children: [
        CircleAvatar(
          radius: iconSize,  // 적절한 크기로 변경
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSizeSubtitle,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: fontSizeSubtitle * 0.7),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}