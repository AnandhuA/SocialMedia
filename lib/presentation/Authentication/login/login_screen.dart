import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/core/style.dart';
import 'package:social_media/presentation/Authentication/forgot_password/forgot_password_screen.dart';
import 'package:social_media/presentation/Authentication/widgets/login_with_google_button.dart';
import 'package:social_media/presentation/Authentication/widgets/password_text_field.dart';
import 'package:social_media/presentation/Authentication/signup/signup_screen.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                constHeight50,
                const LoginWithGoogleButton(),
                constHeight10,
                Text(
                  "Email",
                  style: theme.textTheme.titleLarge,
                ),
                constHeight10,
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                const PasswordTextField(),
                constHeight20,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: linkTextStyle(
                      theme.brightness == Brightness.dark
                          ? whiteColor
                          : blackColor,
                    ),
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
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
