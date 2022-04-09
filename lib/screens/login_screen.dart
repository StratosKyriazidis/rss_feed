import 'package:flutter/material.dart';
import 'package:rss_feed/widgets/login_button.dart';

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
    final _mediaQueryData = MediaQuery.of(context);
    return Center(
      child: Container(
        constraints: BoxConstraints.tight(
          Size.square(_mediaQueryData.size.height / 3),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginButton(string: 'Sign in Anonymously', onTap: anonymous),
            const SizedBox(height: 20.0),
            LoginButton(string: 'Sign in with Email', onTap: emailPassword),
            const SizedBox(height: 20.0),
            LoginButton(string: 'Sign in with Google', onTap: google),
          ],
        ),
      ),
    );
  }
}
