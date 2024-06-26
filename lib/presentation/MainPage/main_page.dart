import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/presentation/AddAndEditPost/add_post_screen.dart';
import 'package:social_media/BLoC/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:social_media/presentation/Home/home_screen.dart';
import 'package:social_media/presentation/Message/message_screen.dart';
import 'package:social_media/presentation/Suggestion/suggestion_screen.dart';
import 'package:social_media/presentation/Explore/explore_screen.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  static List<Widget> screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const AddPostScreen(),
    const SuggestionScreen(),
    const MessageScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
      listener: (context, state) {
        if (state is BottomNavigationInitial) {
          currentIndex = state.index;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: transparentColor,
            unselectedItemColor:
                theme.brightness == Brightness.dark ? whiteColor : blackColor,
            selectedItemColor: primaryColor,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            enableFeedback: true,
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
                icon: Icon(Icons.diversity_3_rounded),
                label: "Suggestion",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Message",
              )
            ],
          ),
        );
      },
    );
  }
}
