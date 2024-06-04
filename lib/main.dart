import 'package:flutter/material.dart';
import 'package:social_media/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:social_media/presentation/intro/intro_screen.dart';
import 'package:social_media/core/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroScreen(),
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
