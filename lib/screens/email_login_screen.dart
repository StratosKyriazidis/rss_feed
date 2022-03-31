import 'package:flutter/material.dart';
import '../widgets/email_login.dart';
import '../widgets/email_signup.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text(
            'RSS Feed',
            textAlign: TextAlign.center,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Login',
              ),
              Tab(
                text: 'Sign Up',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EmailLoginForm(),
            EmailSignupForm(),
          ],
        ),
      ),
    );
  }
}
