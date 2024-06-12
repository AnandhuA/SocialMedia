import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/Authentication/forgot_password/otp_verify.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';
import 'package:social_media/utils/validation.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot password",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerify(
                  email: _emailController.text,
                ),
              ),
            );
          } else if (state is ForgotPasswordErrorState) {
            customSnackbar(
              context: context,
              message: state.error,
              color: errorColor,
            );
          }
        },
        builder: (context, state) {
          return Background(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constHeight50,
                    Center(
                      child: Text(
                        "Please enter your email adderss,\nYou will receive a 4 digit code to verify",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    constHeight50,
                    Text(
                      "Email",
                      style: theme.textTheme.titleLarge,
                    ),
                    constHeight10,
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: Validation.validateEmail,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                        ),
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    constHeight50,
                    state is ForgotPasswordLoadingState
                        ? const LoadingButton()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                    ForgotPasswordSendOtpButtonClickEvent(email: _emailController.text));
                              }
                            },
                            child: const Text("Send OTP"),
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
