import 'package:flutter/material.dart';
import 'package:rss_feed/firebase/user_provider.dart';
import 'package:rss_feed/firebase/user_record.dart';

class FeedListWidget extends StatefulWidget {
  const FeedListWidget({Key? key}) : super(key: key);

  @override
  State<FeedListWidget> createState() => _FeedListWidgetState();
}

class _FeedListWidgetState extends State<FeedListWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context);
    UserRecord userRecord = userProvider.user;

    return Container();
  }
}
