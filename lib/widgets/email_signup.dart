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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseMain>(builder: (context, value, _) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (newValue) => validateEmail(newValue),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your password',
              ),
              obscureText: true,
              validator: (newValue) {
                if (newValue == null || newValue.length < 6) {
                  return 'Password must be over 6 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _confirmController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Confirm password'),
              obscureText: true,
              validator: (newValue) {
                if (newValue == null || newValue != _passwordController.text) {
                  return 'Passwords must match';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  value.emailSignup(
                      _emailController.text, _passwordController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      );
    });
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}
