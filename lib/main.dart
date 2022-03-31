import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rss_feed/screens/login_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseMain>(
      create: (context) => FirebaseMain(),
      child: MaterialApp(
        title: 'Rss Feed',
        theme: ThemeData(
          backgroundColor: Colors.black,
        ),
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
      ),
      backgroundColor: Colors.black,
      body: Consumer<FirebaseMain>(
        builder: (context, value, _) {
          Future.delayed(Duration.zero, () async {
            value.checkLoginStatus();
          });
          if (value.loggedIn == false) {
            return LoginScreen(
              anonymous: value.callAnonymousSignin,
              emailPassword: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailLogin()),
                );
              },
              google: value.callGoogleSignin,
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () => value.signOut(),
                child: const Text('Sign out'),
              ),
            );
          }
        },
      ),
    );
  }
}
