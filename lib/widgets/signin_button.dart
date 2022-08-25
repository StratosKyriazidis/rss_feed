import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({Key? key, required this.string, required this.onTap})
      : super(key: key);

  final String string;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: Theme.of(context).textButtonTheme.style,
      child: Text(
        string,
      ),
    );
  }
}
