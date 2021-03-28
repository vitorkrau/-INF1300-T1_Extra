import 'package:flutter/material.dart';
import 'View/HomeView.dart';
import 'View/AddUserView.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/adduser': (context) => AddUser(),
      },
    ),
  );
}
