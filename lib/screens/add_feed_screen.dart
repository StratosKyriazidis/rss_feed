import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:feed_finder/feed_finder.dart';
import 'package:provider/provider.dart';
import 'package:rss_feed/firebase/firebase_main.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({Key? key}) : super(key: key);

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  final _formkey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQueryData = MediaQuery.of(context);
    return Consumer<FirebaseMain>(
      builder: (context, authState, _) {
        return Card(
          child: Form(
            key: _formkey,
            child: Center(
              child: Container(
                constraints: BoxConstraints.tight(
                  Size.square(_mediaQueryData.size.height / 2),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Put a url here i.e https://www.example.com',
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) => isValidUrl(value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              List<String> feed =
                                  await FeedFinder.scrape(_urlController.text);
                              print('$feed');
                              DocumentReference docIdRef = authState.db
                                  .collection("channels")
                                  .doc(_urlController.text.split('//')[1]);
                              if (feed.isNotEmpty) {
                                docIdRef.get().then((doc) {
                                  if (doc.exists) {
                                    authState.db
                                        .collection("users")
                                        .doc(
                                            authState.userCredential?.user?.uid)
                                        .update({
                                      "channels": FieldValue.arrayUnion(
                                          [docIdRef.path]),
                                    });
                                  } else {
                                    docIdRef.set({
                                      "id": _urlController.text.split('//')[1]
                                    });
                                    authState.db
                                        .collection("users")
                                        .doc(
                                            authState.userCredential?.user?.uid)
                                        .update({
                                      "channels": FieldValue.arrayUnion(
                                          [docIdRef.path]),
                                    });
                                  }
                                });
                              }
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Check for RSS feed'),
                              SizedBox(width: 10.0),
                              Icon(Icons.arrow_circle_right_outlined),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Cancel'),
                              SizedBox(width: 10.0),
                              Icon(Icons.cancel_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String? isValidUrl(String? value) {
  String pattern =
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';

  RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid URL address';
  } else {
    return null;
  }
}
