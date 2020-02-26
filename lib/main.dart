import 'package:flutter/material.dart';
import 'package:bsk_app/splash/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'BskQuiz',
      theme: ThemeData(
     
        primarySwatch: Colors.deepPurple,
      ),
      home: Splashscreen(),
    );
  }
}

