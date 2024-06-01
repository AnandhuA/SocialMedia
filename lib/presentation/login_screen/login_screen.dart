import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/core/style.dart';
import 'package:social_media/presentation/login_screen/widgets/login_with_google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Log In",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginWithGoogleButton(),
              constHeight10,
              Text(
                "Email",
                style: theme.textTheme.titleLarge,
              ),
              constHeight10,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                style: theme.textTheme.titleLarge,
              ),
              constHeight20,
              Text(
                "Password",
                style: theme.textTheme.titleLarge,
              ),
              constHeight10,
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
              ),
              constHeight20,
              Text(
                "Forgot Password?",
                style: linkTextStyle(
                  theme.brightness == Brightness.dark ? whiteColor : blackColor,
                ),
              ),
              constHeight50,
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              constHeight50,
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?  ",
                    style: theme.textTheme.labelLarge,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'SignUp',
                          style: linkTextStyle(
                            theme.brightness == Brightness.dark
                                ? whiteColor
                                : blackColor,
                          )),
                    ],
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
