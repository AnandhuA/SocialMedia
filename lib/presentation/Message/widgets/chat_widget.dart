import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/models/chat_model.dart';

class ChatWidget extends StatelessWidget {
  final Message message;
  final bool isMe;
  const ChatWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isMe ? secondaryColor : primaryColor,
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 0 : 20),
                bottomRight: Radius.circular(isMe ? 20 : 0),
              ),
            ),
            child: Column(
              children: [
                Text(message.text),
                Text(DateFormat.jm().format(message.createdAt))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
