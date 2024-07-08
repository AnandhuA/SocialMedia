import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/BLoC/Explore/explore_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/BLoC/FollowingPost/following_post_bloc.dart';
import 'package:social_media/BLoC/ImageUpload/image_upload_bloc.dart';
import 'package:social_media/BLoC/Suggestion/suggestion_bloc_bloc.dart';
import 'package:social_media/BLoC/UserDetails/user_details_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/core/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/presentation/SplashScreen/splash_screen.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

late String userProfilePic;
late String userName;
late String userId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   userProfilePic = await getUserProfilePic() ??
      "https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png";
      userName = await getUserName()?? "Anonymous";
      userId = await getUserId()?? "Anonymous";
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
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
        BlocProvider(create: (context) => UserPostBloc()),
        BlocProvider(create: (context) => UserDetailsBloc()),
        BlocProvider(create: (context) => FollowBloc()),
        BlocProvider(create: (context) => SuggestionBloc()),
        BlocProvider(create: (context) => ImageUploadBloc()),
        BlocProvider(create: (context) => FollowingPostBloc()),
        BlocProvider(create: (context) => ExploreBloc()),
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
