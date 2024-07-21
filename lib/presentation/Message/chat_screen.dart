import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media/BLoC/Chat/chat_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/chat_model.dart';
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
    super.initState();
    context.read<ChatBloc>().add(ConnectWebSocketEvent());
    context
        .read<ChatBloc>()
        .add(ClickUserEvent(conversationId: widget.conversationId));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    if (date.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else if (date.isAfter(weekAgo)) {
      return DateFormat.EEEE().format(date);
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }

  Map<String, List<Message>> _groupMessagesByDate(List<Message> messages) {
    final Map<String, List<Message>> groupedMessages = {};

    for (var message in messages) {
      final dateKey = _formatDate(DateTime(
        message.createdAt.year,
        message.createdAt.month,
        message.createdAt.day,
      ));

      if (!groupedMessages.containsKey(dateKey)) {
        groupedMessages[dateKey] = [];
      }
      groupedMessages[dateKey]!.add(message);
    }

    return groupedMessages;
  }

  List<Message> messages = [];
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
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is FeatchMessagesSuccessState) {
                      _scrollToBottom();
                    }
                  },
                  builder: (context, state) {
                    if (state is FeatchMessagesSuccessState) {
                      messages = state.messageList;
                      final groupedMessages = _groupMessagesByDate(messages);

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: groupedMessages.length,
                        itemBuilder: (context, index) {
                          final entry =
                              groupedMessages.entries.elementAt(index);
                          final dateHeader = entry.key;
                          final messages = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  dateHeader,
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              ...messages.map((message) => Container(
                                    margin: const EdgeInsets.all(10),
                                    child: ChatWidget(
                                      message: message,
                                      isMe: userId == message.receiverId,
                                    ),
                                  )),
                            ],
                          );
                        },
                      );
                    }
                    final groupedMessages = _groupMessagesByDate(messages);

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: groupedMessages.length,
                      itemBuilder: (context, index) {
                        final entry = groupedMessages.entries.elementAt(index);
                        final dateHeader = entry.key;
                        final messages = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                dateHeader,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            ...messages.map((message) => Container(
                                  margin: const EdgeInsets.all(10),
                                  child: ChatWidget(
                                    message: message,
                                    isMe: userId == message.receiverId,
                                  ),
                                )),
                          ],
                        );
                      },
                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
