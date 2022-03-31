import 'package:flutter/material.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen(
      {Key? key,
      required this.anonymous,
      required this.emailPassword,
      required this.google})
      : super(key: key);

  final VoidCallback anonymous;
  final VoidCallback emailPassword;
  final VoidCallback google;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoginButton(string: 'Sign in Anonymously', onTap: anonymous),
        LoginButton(string: 'Sign in with Email', onTap: emailPassword),
        LoginButton(string: 'Sign in with Google', onTap: google),
      ],
    );
  }
}
