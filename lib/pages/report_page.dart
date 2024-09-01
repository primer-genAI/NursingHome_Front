import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_data.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedVitalSign = '혈압';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('월간 환자 상태 보고서', style: TextStyle(fontSize: 30)), // Increased font size
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '이름: 이성식 (55세 / 남자)\n'
                    '입원일: 2023년8월20일\n'
                    '병실번호: 503호\n'
                    '담당의사: 김철수\n'
                    '기간: 2024년 7월\n',
                style: TextStyle(fontSize: 22), // Increased font size
              ),
              const SizedBox(height: 20),
              _buildPatientSummary(),
              const SizedBox(height: 20),
              _buildVitalSignsGraph(),
              const SizedBox(height: 20),
              _buildHospitalInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientSummary() {
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            '상태 요약',
            style: TextStyle(
              fontSize: 26, // Increased font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Added spacing between title and content
          Text(
            '현재 아버님 상태는 입원 당시 전립선 비대증과 전립선암, 뇌경색, 고혈압, 강직성 편마비, 인지기능 저하, 보행 장애가 있으셨는데요. '
                '지금 현재는 식사 잘하시고, 병원에서 해드릴 수 있는 보존적 치료를 하고 계십니다. 보존적 치료를 하면서 증상에 맞춰서 치료를 진행하고 있는데, '
                '약물 치료, 재활 치료, 지능력 향상 치료를 진행하고 있습니다. 현재 혈압이나 맥박, 체온은 다 정상이시고, 다른 이상 증상은 없으십니다. '
                '지금 현재 의료진의 재활 치료와 약물 치료를 잘 받고 계십니다.',
            style: TextStyle(fontSize: 20, height: 1.5), // Adjusted font size and line height
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignsGraph() {
    return Container(
      height: 200, // Reduced height
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '활력 징후',
            style: TextStyle(
              fontSize: 26, // Increased font size
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVitalSignButton('혈압'),
              _buildVitalSignButton('맥박'),
              _buildVitalSignButton('호흡'),
              _buildVitalSignButton('체온'),
            ],
          ),
          const SizedBox(height: 5), // Reduced spacing
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
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }

  List<ChartData> _getVitalSignData(String vitalSign) {
    switch (vitalSign) {
      case '혈압':
        return [
          ChartData('7월 1일', 120),
          ChartData('7월 5일', 125),
          ChartData('7월 10일', 130),
          ChartData('7월 15일', 128),
          ChartData('7월 20일', 122),
          ChartData('7월 25일', 118),
          ChartData('7월 30일', 126),
        ];
      case '맥박':
        return [
          ChartData('7월 1일', 70),
          ChartData('7월 5일', 72),
          ChartData('7월 10일', 68),
          ChartData('7월 15일', 75),
          ChartData('7월 20일', 70),
          ChartData('7월 25일', 73),
          ChartData('7월 30일', 69),
        ];
      case '호흡':
        return [
          ChartData('7월 1일', 16),
          ChartData('7월 5일', 17),
          ChartData('7월 10일', 15),
          ChartData('7월 15일', 18),
          ChartData('7월 20일', 16),
          ChartData('7월 25일', 17),
          ChartData('7월 30일', 16),
        ];
      case '체온':
        return [
          ChartData('7월 1일', 36.5),
          ChartData('7월 5일', 36.6),
          ChartData('7월 10일', 36.7),
          ChartData('7월 15일', 36.5),
          ChartData('7월 20일', 36.8),
          ChartData('7월 25일', 36.6),
          ChartData('7월 30일', 36.7),
        ];
      default:
        return [];
    }
  }

  Widget _buildHospitalInfo() {
    // Placeholder for Hospital Information
    return Container(
      width: double.infinity,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '병원 정보',
            style: TextStyle(
              fontSize: 26, // Increased font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Added spacing between title and content
          Text(
            '병원 연락처 : 02-2347-1206\n병원 이메일: contact@nursinghospital.com\n병원 홈페이지: http://www.nursinghospital.com',
            style: TextStyle(fontSize: 20, height: 1.5), // Adjusted font size and line height
          ),
        ],
      ),
    );
  }
}