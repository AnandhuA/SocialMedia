import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 70,
              maxWidth: 400,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: isMe ? secondaryColor : primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(10),
                  topLeft: const Radius.circular(10),
                  bottomLeft: Radius.circular(isMe ? 0 : 10),
                  bottomRight: Radius.circular(isMe ? 10 : 0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.text),
                  constHeight3,
                  Text(
                    DateFormat.jm().format(message.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: greyColor300,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
