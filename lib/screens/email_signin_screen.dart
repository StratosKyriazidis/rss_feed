import 'package:flutter/material.dart';
import 'package:rss_feed/widgets/email_signin.dart';
import 'package:rss_feed/widgets/email_signup.dart';

class EmailSignin extends StatelessWidget {
  const EmailSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'RSS Feed',
            textAlign: TextAlign.center,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Log in'),
              Tab(text: 'Sign Up'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EmailSigninForm(),
            EmailSignupForm(),
          ],
        ),
      ),
    );
  }
}
