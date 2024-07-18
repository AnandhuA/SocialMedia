import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Chat/chat_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/Message/chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    context.read<ChatBloc>().add(FeatchMessageListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: SafeArea(
        child: Column(
          children: [
            const CustomAppbar(
              title: "Message",
            ),
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is FetchMessageListSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.userList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                   
                                    receiverId: state.userList[index].id,
                                    conversationId: state.chatList[index].id,
                                  ),
                                ));
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              state.userList[index].profilePic ??
                                  "https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
                            ),
                          ),
                          title: Text(
                            state.userList[index].name ??
                                state.userList[index].userName,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
