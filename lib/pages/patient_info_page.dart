import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chat_page.dart';
import 'chart_data.dart';

class PatientInfoPage extends StatefulWidget {
  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  String selectedVitalSign = '혈압';
  String healthStatus = '양호';

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
              SizedBox(height: 30),
              _buildVitalSignsGraph(),
              SizedBox(height: 30),
              _buildAIConsultationSection(context),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildPatientInfoSection() {
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
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage('assets/images/patient_photo.png'),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름: 김환자 / 남, 45세', style: TextStyle(fontSize: 24)),
                  Text('입원일: 2024년 8월 2일', style: TextStyle(fontSize: 24)),
                  Text('병실 번호: 502호(4인실)', style: TextStyle(fontSize: 24)),
                  Text('담당 의사: 김철수', style: TextStyle(fontSize: 24)),
                ],
              ),
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
          Text(
            '오늘의 처방 및 시술 내용과 하루일과를 확인할 수 있습니다.',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 20),
          _buildServiceIconsSection(),
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

  Widget _buildServiceIconsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceIcon('의사', 'assets/images/doctor_icon.png', 1),
        _buildServiceIcon('의사', 'assets/images/nurse_icon.png', 5),
        _buildServiceIcon('행정 안내', 'assets/images/document_icon.png', 2),
      ],
    );
  }

  Widget _buildServiceIcon(String label, String imagePath, int notificationCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 50, height: 50),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              notificationCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitalSignsGraph() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16.0),
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
          Text(
            '활력 징후',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVitalSignButton('혈압'),
              _buildVitalSignButton('맥박'),
              _buildVitalSignButton('호흡'),
              _buildVitalSignButton('체온'),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  dataSource: _getVitalSignData(selectedVitalSign),
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignButton(String vitalSign) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedVitalSign = vitalSign;
        });
      },
      child: Text(vitalSign),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedVitalSign == vitalSign ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  List<ChartData> _getVitalSignData(String vitalSign) {
    switch (vitalSign) {
      case '혈압':
        return [
          ChartData('10:00', 120),
          ChartData('12:00', 125),
          ChartData('14:00', 130),
          ChartData('16:00', 128),
        ];
      case '맥박':
        return [
          ChartData('10:00', 70),
          ChartData('12:00', 75),
          ChartData('14:00', 72),
          ChartData('16:00', 68),
        ];
      case '호흡':
        return [
          ChartData('10:00', 16),
          ChartData('12:00', 18),
          ChartData('14:00', 17),
          ChartData('16:00', 19),
        ];
      case '체온':
        return [
          ChartData('10:00', 36.5),
          ChartData('12:00', 36.7),
          ChartData('14:00', 36.6),
          ChartData('16:00', 36.8),
        ];
      default:
        return [];
    }
  }

  Widget _buildAIConsultationSection(BuildContext context) {
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
          Text(
            '환자안심케어 요양병원 AI',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            '효도AI',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                child: _buildAIConsultantTile(
                  'AI 상담사 간단이',
                  'assets/images/nurse2.png',
                  '전문적이고 요점만 간단히 환자분의 상황을 알려드립니다.',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                child: _buildAIConsultantTile(
                  'AI 상담사 친절이',
                  'assets/images/nurse1.png',
                  '친절하고 자세하게 환자분의 상황을 설명해드리겠습니다.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIConsultantTile(String title, String imagePath, String subtitle) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 150,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}