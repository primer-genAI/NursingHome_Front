import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global_state.dart';
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class ChatPage extends StatefulWidget {
  final int nurseIdx;

  const ChatPage({required this.nurseIdx});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  late stt.SpeechToText _speech; // Speech to Text instance
  bool _isListening = false;
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }


  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      messages.add({"role": "human", "content": _controller.text});
      _isLoading = true;
    });

    // final url = Uri.parse('http://localhost:8000/n${widget.nurseIdx}');
    final url = Uri.parse('http://104.198.208.62:5001/n${widget.nurseIdx}');

    final headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
    };

    final body = json.encode({
      "question": _controller.text,
      "patient_id": GlobalState.patientId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        setState(() {
          messages.add({"role": "bot", "content": responseBody['response']});
        });
      } else {
        setState(() {
          messages.add({"role": "error", "content": "Error: ${response.statusCode}"});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "error", "content": "Failed to connect to the server: $e"});
      });
    }

    setState(() {
      _isLoading = false;
    });

    _controller.clear();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          setState(() {
            _isListening = _speech.isListening;
          });
        },
        onError: (val) {
          setState(() {
            _isListening = false;
          });
          print('onError: $val');
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _recognizedText = val.recognizedWords;
            _controller.text = _recognizedText;
          }),
          localeId: "ko_KR", // Set the language to Korean
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }


  Widget _buildMessage(Map<String, String> message) {
    bool isHuman = message['role'] == "human";
    bool isError = message['role'] == "error";
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Align(
        alignment: isHuman ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isError
                ? Colors.redAccent
                : isHuman
                    ? Colors.blueAccent
                    : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: isHuman ? Radius.circular(16) : Radius.zero,
              bottomRight: isHuman ? Radius.zero : Radius.circular(16),
            ),
          ),
          child: Text(
            message['content']!,
            style: TextStyle(
              color: isHuman ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI 상담사'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return _buildMessage(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          if (_isListening) // Show real-time transcription
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _recognizedText.isEmpty
                    ? 'Listening...'
                    : 'Recognizing: $_recognizedText',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: 1, // Increase the height of the input field
                    decoration: InputDecoration(
                      hintText: '메시지 입력...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(
                      fontSize: 25, // Increase font size
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                // Enlarged Mic Icon
                SizedBox(
                  width: 60,  // Set width and height for the microphone icon
                  height: 60,
                  child: IconButton(
                    iconSize: 40,  // Increase icon size
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.red : Colors.blueAccent,
                    ),
                    onPressed: _listen,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
