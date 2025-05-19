import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiService {
  static const String _baseUrl =
      'https://openrouter.ai/api/v1/chat/completions';
  static final String _apiKey = dotenv.env['API_KEY_ROUTER_KEYs'] ?? '';

  // static const String _apiKey =
  //     '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';

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
