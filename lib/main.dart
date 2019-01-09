import 'package:flutter/material.dart';
import 'package:flutter_userlist_app/ui/friends/friends_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFFF850DD),
      ),
      home: new FriendsPage(),
    );
  }
}