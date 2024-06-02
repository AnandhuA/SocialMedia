import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/core/style.dart';
import 'package:social_media/presentation/Authentication/forgot_password/forgot_password_screen.dart';
import 'package:social_media/presentation/Authentication/widgets/login_with_google_button.dart';
import 'package:social_media/presentation/Authentication/widgets/password_text_field.dart';
import 'package:social_media/presentation/Authentication/signup/signup_screen.dart';
import 'package:social_media/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:social_media/presentation/custom_widgets/custom_snackbar.dart';
import 'package:social_media/presentation/custom_widgets/loading_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          customSnackbar(
              context: context, message: "Sucess", color: successColor);
        }
        if (state is LoginErrorState) {
          customSnackbar(
              context: context, message: state.error, color: errorColor);
        }
      },
      builder: (context, state) {
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
                child: Form(
                  key: _formKey,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email address";
                          }
                          return null;
                        },
                        controller: _emailController,
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
                      PasswordTextField(
                        controller: _passwordController,
                      ),
                      constHeight20,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
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
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const LoadingButton();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              log("ButtonClicked");
                              if (_formKey.currentState!.validate()) {
                                log("ok");
                              } else {
                                log("No");
                              }
                              context
                                  .read<AuthenticationBloc>()
                                  .add(LoginButtonClickEvent());
                            },
                            child: const Text("Login"),
                          );
                        },
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
                                        builder: (context) => SignupScreen(),
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
          ),
        );
      },
    );
  }
}
