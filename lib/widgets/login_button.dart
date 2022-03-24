import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.string, required this.onTap})
      : super(key: key);

  final String string;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.purple,
      child: TextButton(
        onPressed: onTap,
        child: Text(
          string,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
