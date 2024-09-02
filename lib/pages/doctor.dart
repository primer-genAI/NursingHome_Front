import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_data.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  String selectedVitalSign = '혈압';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환자 정보 페이지', style: TextStyle(fontSize: 28)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverallStatusGauge(),
              SizedBox(height: 20),
              _buildVitalSignsGraph(),
            ],
          ),
        ),
      ),
    );
  }

  // 반원형 게이지
  Widget _buildOverallStatusGauge() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
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
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            startAngle: 180,
            endAngle: 0,
            showTicks: false,
            showLabels: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 20,
                color: Colors.red,
                startWidth: 50,
                endWidth: 50,
                label: '위험',
                labelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GaugeRange(
                startValue: 20,
                endValue: 40,
                color: Colors.deepOrange,
                startWidth: 50,
                endWidth: 50,
                label: '주의',
                labelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GaugeRange(
                startValue: 40,
                endValue: 60,
                color: Colors.yellow,
                startWidth: 50,
                endWidth: 50,
                label: '양호',
                labelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GaugeRange(
                startValue: 60,
                endValue: 80,
                color: Colors.green,
                startWidth: 50,
                endWidth: 50,
                label: '호전',
                labelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GaugeRange(
                startValue: 80,
                endValue: 100,
                color: Colors.blue,
                startWidth: 50,
                endWidth: 50,
                label: '건강',
                labelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: _calculateOverallStatus(),
                needleColor: Colors.black,
                knobStyle: KnobStyle(color: Colors.black),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Text(
                    '${_calculateOverallStatus().toInt()}%',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                angle: 90,
                positionFactor: 0.8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 종합 상태 계산
  double _calculateOverallStatus() {
    // 예시로 75를 반환합니다.
    return 75;
  }

  Widget _buildVitalSignsGraph() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVitalSignButton('혈압'),
              _buildVitalSignButton('맥박'),
              _buildVitalSignButton('호흡'),
              _buildVitalSignButton('체온'),
            ],
          ),
          const SizedBox(height: 10),
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
}