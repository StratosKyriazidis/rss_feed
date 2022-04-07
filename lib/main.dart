import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rss_feed/screens/add_feed_screen.dart';
import 'package:rss_feed/screens/login_screen.dart';
import 'package:rss_feed/themes/theme_manager.dart';
import 'package:rss_feed/themes/themes.dart';
import 'firebase/firebase_main.dart';
import 'firebase/firebase_options.dart';
import './screens/email_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseMain>(
      create: (context) => FirebaseMain(),
      child: MaterialApp(
        title: 'Rss Feed',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSS Feed'),
        actions: [
          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
              setState(() {});
            },
          ),
          Consumer<FirebaseMain>(builder: (context, authState, _) {
            Future.delayed(Duration.zero, () async {
              authState.checkLoginStatus();
            });
            return Visibility(
              visible: authState.loggedIn != null && authState.loggedIn == true,
              child: IconButton(
                onPressed: () => authState.signOut(),
                icon: const Icon(Icons.logout_rounded),
              ),
              replacement: const SizedBox(width: 50.0),
            );
          }),
        ],
      ),
      body: Consumer<FirebaseMain>(
        builder: (context, authState, _) {
          Future.delayed(Duration.zero, () async {
            authState.checkLoginStatus();
          });
          if (authState.loggedIn == false) {
            return LoginScreen(
              anonymous: authState.callAnonymousSignin,
              emailPassword: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailLogin()),
                );
              },
              google: authState.callGoogleSignin,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: Consumer<FirebaseMain>(
        builder: (context, authState, _) {
          Future.delayed(Duration.zero, () async {
            authState.checkLoginStatus();
          });
          return Visibility(
            visible: authState.loggedIn != null && authState.loggedIn == true,
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddFeed()),
                );
              }),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.rss_feed_outlined),
                  Icon(Icons.add_outlined),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
