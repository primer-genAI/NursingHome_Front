import 'package:flutter/material.dart';
import 'chat_page.dart';

class AINursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('효도AI', style: TextStyle(fontSize: 28)),
        automaticallyImplyLeading: true, // 뒤로가기 버튼 추가
      ),
      body: _buildAIConsultationSection(context),
    );
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