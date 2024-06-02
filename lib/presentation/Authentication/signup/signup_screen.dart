import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/core/style.dart';
import 'package:social_media/presentation/Authentication/widgets/password_text_field.dart';
import 'package:social_media/presentation/Authentication/login/login_screen.dart';
import 'package:social_media/presentation/Authentication/verification/verification_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
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
                Text(
                  "Name",
                  style: theme.textTheme.titleLarge,
                ),
                constHeight10,
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                  style: theme.textTheme.titleLarge,
                ),
                constHeight30,
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
                constHeight30,
                Text(
                  "Phone",
                  style: theme.textTheme.titleLarge,
                ),
                constHeight10,
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Phone",
                  ),
                  style: theme.textTheme.titleLarge,
                ),
                constHeight30,
                Text(
                  "Password",
                  style: theme.textTheme.titleLarge,
                ),
                constHeight10,
                const PasswordTextField(),
                constHeight50,
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(),
                      ),
                    );
                  },
                  child: const Text("Sign Up"),
                ),
                constHeight50,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?  ",
                      style: theme.textTheme.labelLarge,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
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
                                  builder: (context) => const LoginScreen(),
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
