import 'package:flutter/material.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen(
      {Key? key,
      required this.anonym,
      required this.empass,
      required this.goog})
      : super(key: key);

  final VoidCallback anonym;
  final VoidCallback empass;
  final VoidCallback goog;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginButton(string: 'Sign in Anonymously', onTap: anonym),
        LoginButton(string: 'Sign in with Email', onTap: empass),
        LoginButton(string: 'Sign in with Google', onTap: goog),
      ],
    );
  }
}
