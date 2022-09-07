import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_feed/firebase/user_record.dart';

import 'backend.dart';

class UserProvider with ChangeNotifier {
  static UserProvider of(BuildContext context, {listen = true}) {
    return Provider.of<UserProvider>(context, listen: listen);
  }

  UserProvider() {
    _getUser();
  }

  refresh() {
    _getUser();
  }

  StreamSubscription? _userStreamSubscription;
  bool isLoading = true;

  UserRecord _userRecord = UserRecord();
  List<UserRecord> _usersRecord = [UserRecord()];

  List<UserRecord> get usersRecord => _usersRecord;

  UserRecord get user => _usersRecord.singleWhere(
        (element) => element.id == FirebaseAuth.instance.currentUser?.uid,
        orElse: () => UserRecord(),
      );

  Future<void> _getUser() async {
    _userStreamSubscription?.cancel();
    _userStreamSubscription = queryUserRecord(
      queryBuilder: (rec) => rec,
    ).listen((data) {
      _usersRecord = data;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> clearLocalData() async {
    _usersRecord = [];
  }

  @override
  void dispose() {
    isLoading = true;
    _userStreamSubscription?.cancel();
    super.dispose();
  }
}
