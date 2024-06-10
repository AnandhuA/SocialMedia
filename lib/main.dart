import 'package:flutter/material.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/core/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:social_media/presentation/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => BottomNavigationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
