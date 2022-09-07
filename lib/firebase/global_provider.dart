import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_feed/firebase/user_provider.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: ((context) => UserProvider()),
        ),
      ],
      child: child,
    );
  }
}
