import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/Authentication/login/login_screen.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';
import 'package:social_media/utils/validation.dart';

class NewPasswordScreen extends StatelessWidget {
  final String email;
  NewPasswordScreen({
    super.key,
    required this.email,
  });
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New password",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is NewPasswordSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false,
            );
          } else if (state is NewPasswordErrorState) {
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      constHeight50,
                      Text(
                        "New password",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextFormField(
                        controller: _newPasswordController,
                        validator: Validation.validatePassword,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "New Password",
                        ),
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight40,
                      Text(
                        "Confirm password",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: Validation.validatePassword,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Confirm password",
                        ),
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      state is NewPasswordLoadingState
                          ? const LoadingButton()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_newPasswordController.text ==
                                      _confirmPasswordController.text) {
                                    context.read<AuthenticationBloc>().add(
                                          NewPasswordSaveButtonClickEvent(
                                            email: email,
                                            password: _newPasswordController.text,
                                          ),
                                        );
                                  } else {
                                    customSnackbar(
                                      context: context,
                                      message: "Password NotMatch",
                                      color: errorColor,
                                    );
                                  }
                                }
                              },
                              child: const Text("Save"),
                            ),
                      constHeight50
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
