import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/presentation/AddPost/add_post_screen.dart';
import 'package:social_media/BLoC/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:social_media/presentation/Home/home_screen.dart';
import 'package:social_media/presentation/Message/message_screen.dart';
import 'package:social_media/presentation/Nottification/notification_screen.dart';
import 'package:social_media/presentation/Search/search_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const NotificationScreen(),
    const MessageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is BottomNavigationInitial) {
            currentIndex = state.index;
          }
          return screens[currentIndex];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is BottomNavigationInitial) {
            currentIndex = state.index;
          }
          return BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            selectedItemColor: primaryColor,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (value) {
              context
                  .read<BottomNavigationCubit>()
                  .bottomNvigationButtonClick(index: value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "Notification",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Message",
              )
            ],
          );
        },
      ),
    );
  }
}
