import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.white12,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.white70,
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../models/chat_message.dart';

// class MessageBubble extends StatelessWidget {
//   final ChatMessage message;

//   const MessageBubble({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isUser = message.sender == 'user';

//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
//         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         decoration: BoxDecoration(
//           gradient: isUser
//               ? LinearGradient(
//                   colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : LinearGradient(
//                   colors: [Color(0xFFE5E5E5), Color(0xFFBDBDBD)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomLeft: isUser ? Radius.circular(20) : Radius.circular(4),
//             bottomRight: isUser ? Radius.circular(4) : Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0, 3),
//               blurRadius: 6,
//             ),
//           ],
//         ),
//         child: Text(
//           message.text,
//           style: GoogleFonts.openSans(
//             fontSize: 16,
//             color: isUser ? Colors.white : Colors.black87,
//             height: 1.3,
//           ),
//         ),
//       ),
//     );
//   }
// }
