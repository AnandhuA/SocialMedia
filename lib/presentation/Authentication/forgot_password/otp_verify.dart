import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/Authentication/forgot_password/new_password_screen.dart';
import 'package:social_media/presentation/Authentication/widgets/otp_text_filed.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';

class OtpVerify extends StatelessWidget {
  final String email;
  OtpVerify({
    super.key,
    required this.email,
  });
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is VerificationSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  NewPasswordScreen(email: email,),
            ),
          );
        } else if (state is VerificationErrorState) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verification",
                  style: theme.textTheme.headlineLarge,
                ),
                constHeight10,
                Text(
                  "We have send verification code to\n$email",
                  style: theme.textTheme.labelLarge,
                ),
                constHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    textBoxWidget(context: context, controller: otpController1),
                    textBoxWidget(context: context, controller: otpController2),
                    textBoxWidget(context: context, controller: otpController3),
                    textBoxWidget(context: context, controller: otpController4),
                  ],
                ),
                constHeight20,
                constHeight50,
                state is VerificationLoadingState
                    ? const LoadingButton()
                    : ElevatedButton(
                        onPressed: () {
                          if (otpController1.text.isNotEmpty &&
                              otpController2.text.isNotEmpty &&
                              otpController3.text.isNotEmpty &&
                              otpController4.text.isNotEmpty) {
                            final otp = otpController1.text +
                                otpController2.text +
                                otpController3.text +
                                otpController4.text;
                            context.read<AuthenticationBloc>().add(
                                  ForgotPasswordOtpVerficationButtonClickEvent(
                                    email: email,
                                    otp: otp,
                                  ),
                                );
                          }
                        },
                        child: const Text("Confirm"),
                      )
              ],
            ),
          ),
        );
      },
    ));
  }
}
