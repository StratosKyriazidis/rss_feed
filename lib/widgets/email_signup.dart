import 'package:flutter/material.dart';
import '../firebase/firebase_main.dart';
import 'package:provider/provider.dart';

class EmailSignupForm extends StatefulWidget {
  const EmailSignupForm({Key? key}) : super(key: key);

  @override
  State<EmailSignupForm> createState() => _EmailSignupFormState();
}

class _EmailSignupFormState extends State<EmailSignupForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseMain>(builder: (context, value, _) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Email'),
            TextFormField(
              onSaved: (value) {
                _email = value.toString();
              },
            ),
            const Text('Password'),
            TextFormField(
              onSaved: (value) {
                _password = value.toString();
              },
            ),
            const Text('Confirm Password'),
            TextFormField(
              onSaved: (value) {
                _confirmPassword = value.toString();
              },
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                value.validateSignup(_email, _password, _confirmPassword);
                // if (value
                //         .validateSignup(_email, _password, _confirmPassword)
                //         .toString() ==
                //     'email-already-in-use') {
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text('Email already in use'),
                //   ));
                //   _formKey.currentState!.reset();
                // } else if (value
                //         .validateSignup(_email, _password, _confirmPassword)
                //         .toString() ==
                //     'weak-password') {
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text('Weak password'),
                //   ));
                //   _formKey.currentState!.reset();
                // } else if (value
                //         .validateSignup(_email, _password, _confirmPassword)
                //         .toString() ==
                //     'unmatching-passwords') {
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text('Passwords in both fields must be the same'),
                //   ));
                //   _formKey.currentState!.reset();
                // } else {
                //   value.validateSignup(_email, _password, _confirmPassword);
                // }
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      );
    });
  }
}
