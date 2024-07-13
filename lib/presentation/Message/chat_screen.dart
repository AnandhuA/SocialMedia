import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Chat/chat_bloc.dart';
import 'package:social_media/core/bacground.dart';

import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
            child: Column(
          children: [
            const CustomAppbar(title: "Chat"),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatSuccessState) {
                    return ListView.builder(
                      itemCount: state.chatList.length,
                      controller: _scrollController,
                      reverse: true,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        child: Text(state.chatList[(list.length - 1) - index]),
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
                decoration: InputDecoration(
                  hintText: "Message",
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        context.read<ChatBloc>().add(
                              SendMessageEvent(
                                  message: _messageController.text),
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
