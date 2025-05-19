class ChatMessage {
  final String id;
  final String text;
  final String sender; // 'user' ya 'bot'

  ChatMessage({required this.id, required this.text, required this.sender});
}
