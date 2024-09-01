import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 페이지', style: TextStyle(fontSize: 28)),
        automaticallyImplyLeading: true, // 뒤로가기 버튼 자동 추가
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPatientInfoSection(),
              // 아래 코드들은 필요에 따라 다시 주석을 해제해 사용하세요.
              // SizedBox(height: 30),
              // _buildVitalSignsGraph(),
              // SizedBox(height: 30),
              // _buildAIConsultationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoSection() {
    final String name = widget.userInfo['이름'] ?? '이름 없음';
    final String gender = widget.userInfo['성별'] ?? '성별 없음';
    final int age = widget.userInfo['나이'] ?? 0;
    final String admissionDate = widget.userInfo['입원일'] ?? '날짜 없음';
    final String roomNumber = widget.userInfo['병실번호'] ?? '병실 없음';
    final String roomInfo = widget.userInfo['병실정보'] ?? '병실 없음';
    final String doctor = widget.userInfo['담당의사'] ?? '담당의 없음';
    final String imgPath = widget.userInfo['image_path'] ?? 'No Image';

    final String imgUrl = 'http://104.198.208.62/assets/$imgPath';

    final List<dynamic> diagList = widget.userInfo['질환명'] ?? [];
    final String diag = diagList.join(', '); // 리스트를 문자열로 변환

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
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildHealthStatusButton(),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: CircleAvatar(
              radius: 100,  // 적절한 크기로 변경
              backgroundImage: NetworkImage(imgUrl),  // 경로 확인 필요
            ),

          ),

          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('◦ 이름: $name / $gender, ${age}세', style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Text('◦ 입원일: $admissionDate', style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Text('◦ 병실 번호: $roomNumber호($roomInfo)', style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Text('◦ 담당 의사: $doctor', style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Text('◦ 질환: $diag', style: TextStyle(fontSize: 24)),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '오늘의 상태 요약:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text('◦ 특이사항 없음', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }

  Widget _buildHealthStatusButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          healthStatus = healthStatus == '양호' ? '위험' : '양호';
        });
      },
      child: Text(healthStatus, style: TextStyle(fontSize: 22)),
      style: ElevatedButton.styleFrom(
        backgroundColor: healthStatus == '양호' ? Colors.green : Colors.red,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}