import 'package:flutter/material.dart';
import 'package:bsk_app/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'BSK QUIZ',
      theme: ThemeData(
     
        primarySwatch: Colors.indigo,
      ),
      home: Splashscreen(),
    );
  }
}

