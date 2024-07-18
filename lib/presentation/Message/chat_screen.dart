import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Chat/chat_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/main.dart';

import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/Message/widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {

  final String receiverId;
  final String conversationId;
  const ChatScreen({
    super.key,
 
    required this.receiverId,
    required this.conversationId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<ChatBloc>()
        .add(ClickUserEvent(conversationId: widget.conversationId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Background(
        child: SafeArea(
            child: Column(
          children: [
            const CustomAppbar(title: "Chat"),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is FeatchMessagesSuccessState) {
                    return ListView.builder(
                      itemCount: state.messageList.length,
                      controller: _scrollController,
                      reverse: true,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(10),
                        child: ChatWidget(
                          message: state.messageList[
                              (state.messageList.length - 1) - index],
                          isMe: userId ==
                              state
                                  .messageList[
                                      (state.messageList.length - 1) - index]
                                  .receiverId,
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 20),
              height: 80,
              child: TextField(
                controller: _messageController,
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  hintText: "Message",
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        context.read<ChatBloc>().add(
                              SendMessageEvent(
                                message: _messageController.text,
                                receiverId: widget.receiverId,
                                conversationId: widget.conversationId,
                              ),
                            );
                        _messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
