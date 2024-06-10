import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/core/style.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/Authentication/widgets/password_text_field.dart';
import 'package:social_media/presentation/Authentication/login/login_screen.dart';
import 'package:social_media/presentation/Authentication/verification/verification_screen.dart';
import 'package:social_media/BLoC/Authentication/authentication_bloc.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';
import 'package:social_media/utils/validation.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is SignupErrorState) {
            customSnackbar(
                context: context, message: state.error, color: errorColor);
          } else if (state is SignupSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  userModel: state.model,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Background(
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
                      Text(
                        "Username",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextFormField(
                        validator: Validation.validateName,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Username",
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
                        validator: Validation.validateEmail,
                        controller: _emailController,
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
                        validator: Validation.validatePhone,
                        controller: _phoneController,
                        maxLength: 10,
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
                      PasswordTextField(
                        controller: _passwordController,
                      ),
                      constHeight50,
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is SignupLoadingState) {
                            return const LoadingButton();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UserModel newModel = UserModel(
                                  userName: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                );
                                context.read<AuthenticationBloc>().add(
                                      SignupButtonClickEvent(
                                        userModel: newModel,
                                      ),
                                    );
                              }
                            },
                            child: const Text("Sign Up"),
                          );
                        },
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
                                        builder: (context) => LoginScreen(),
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
        },
      ),
    );
  }
}
