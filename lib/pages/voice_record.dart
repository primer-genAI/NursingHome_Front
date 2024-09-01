import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Info',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: VoiceQueryScreen(),
    );
  }
}

class VoiceQueryScreen extends StatefulWidget {
  @override
  _VoiceQueryScreenState createState() => _VoiceQueryScreenState();
}

class _VoiceQueryScreenState extends State<VoiceQueryScreen> {
  String question = '남해고속도로 막혀?'; // Example question
  String response = '남해고속도로 교통정보는 아래와 같아요'; // Example response

  // You'd call your API endpoint here
  void fetchResponse(String query) {
    // Logic to call your FastAPI backend
    // Use http package to POST the query to your /process-query endpoint
    setState(() {
      // Update response based on the result from your backend
      response = "API response here"; // Replace with actual response from backend
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Query App'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Close action
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input area for voice command or text input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          // Display the response
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  response,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                // Example of detailed info layout
                Card(
                  child: ListTile(
                    leading: Icon(Icons.traffic),
                    title: Text('남해고속도로'),
                    subtitle: Text('사고 발생, 공사중'),
                    trailing: Text('168.4km'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Microphone button for voice input (placeholder)
          IconButton(
            icon: Icon(Icons.mic, size: 36),
            onPressed: () {
              // Implement voice input functionality here
            },
          ),
        ],
      ),
    );
  }
}