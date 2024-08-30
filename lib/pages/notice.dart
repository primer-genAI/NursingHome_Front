import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지 사항', style: TextStyle(fontSize: 28)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildServiceIconsSection(context),
      ),
    );
  }

  Widget _buildServiceIconsSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceIcon(context, '의사', 'assets/images/doctor_icon.png', 1),
        _buildServiceIcon(context, '간호사', 'assets/images/nurse_icon.png', 5),
        _buildServiceIcon(context, '행정 안내', 'assets/images/document_icon.png', 2),
      ],
    );
  }

  Widget _buildServiceIcon(BuildContext context, String label, String imagePath, int notificationCount) {
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


}