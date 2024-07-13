import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/Message/chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
            Expanded(
                child: ListView.separated(
              itemCount: 32,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ChatScreen(),
                    ),
                  ),
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    ),
                  ),
                  title: Text("name$index"),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ))
          ],
        ),
      )),
    );
  }
}
