import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/api_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(id: '1', text: '👋 Hello! How can I help you today?', sender: 'bot'),
  ];

  final TextEditingController _textController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false;

  void _addMessage(ChatMessage message) {
    _messages.insert(0, message);
    _listKey.currentState?.insertItem(0);
  }

  Future<void> _handleSend() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      text: text,
      sender: 'user',
    );

    _addMessage(userMessage);
    _textController.clear();

    setState(() => _isLoading = true);

    try {
      final botReply = await ApiService.sendMessage(text);
      _addMessage(ChatMessage(
        id: DateTime.now().toString() + '_bot',
        text: botReply,
        sender: 'bot',
      ));
    } catch (e) {
      _addMessage(ChatMessage(
        id: DateTime.now().toString() + '_error',
        text: '❌ Error getting response.',
        sender: 'bot',
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('AI ChatBot'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 10,
        shadowColor: Colors.deepOrangeAccent.withOpacity(0.5),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              reverse: true,
              padding: const EdgeInsets.all(12),
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeOut)),
                  ),
                  child: MessageBubble(message: _messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    enabled: !_isLoading,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                if (_isLoading)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.orange,
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.orange),
                    onPressed: _handleSend,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../models/chat_message.dart';
// import '../services/api_service.dart';
// import '../widgets/message_bubble.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<ChatMessage> _messages = [
//     ChatMessage(id: '1', text: 'Hello! How can I help you?', sender: 'bot'),
//   ];

//   final TextEditingController _textController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   bool _isLoading = false;

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   Future<void> _handleSend() async {
//     final text = _textController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.insert(
//         0,
//         ChatMessage(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           text: text,
//           sender: 'user',
//         ),
//       );
//       _isLoading = true;
//     });

//     _textController.clear();
//     _scrollToBottom();

//     try {
//       final botResponse = await ApiService.sendMessage(text);
//       setState(() {
//         _messages.insert(
//           0,
//           ChatMessage(
//             id: DateTime.now().millisecondsSinceEpoch.toString() + '_bot',
//             text: botResponse,
//             sender: 'bot',
//           ),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         _messages.insert(
//           0,
//           ChatMessage(
//             id: DateTime.now().millisecondsSinceEpoch.toString() + '_bot',
//             text: '❌ Failed to get response from AI.',
//             sender: 'bot',
//           ),
//         );
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//       _scrollToBottom();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:  Colors.black,
//       appBar: AppBar(
//         title: Text(
//           'AI Chat',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.1,
//             color: Colors.black,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: Colors.orange,
//         elevation: 5,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 reverse: true,
//                 controller: _scrollController,
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   return MessageBubble(message: _messages[index]);
//                 },
//               ),
//             ),
//             const Divider(height: 1),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextField(
//                         controller: _textController,
//                         enabled: !_isLoading,
//                         textCapitalization: TextCapitalization.sentences,
//                         decoration: const InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                           hintText: 'Type your message...',
//                           border: InputBorder.none,
//                         ),
//                         onSubmitted: (_) => _handleSend(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   CircleAvatar(
//                     radius: 26,
//                     backgroundColor: Colors.orange,
//                     child: _isLoading
//                         ? const Padding (
//                             padding: EdgeInsets.all(6.0),
//                             child: CircularProgressIndicator(
//                               color: Colors.black,
//                               strokeWidth: 3,
//                             ),
//                           )
//                         : IconButton(
//                             icon: const Icon(Icons.send, color: Colors.white),
//                             onPressed: _handleSend,
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
