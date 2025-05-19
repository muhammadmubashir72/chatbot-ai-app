import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://openrouter.ai/api/v1/chat/completions';
  static const String _apiKey =
      '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'; // Replace with your key

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
        'HTTP-Referer': 'https://ai-chat-pro.app',
        // 'HTTP-Referer': 'https://your-app-name.com',
        'X-Title': 'AI Chat Pro',
      },
      body: jsonEncode({
        'model': 'openai/gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message},
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to get AI response');
    }
  }
}
