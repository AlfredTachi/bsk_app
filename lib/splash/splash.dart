import 'dart:async';

//import 'package:bsk_app/home/home.dart';
import 'package:bsk_app/login/login.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        //builder: (context) => Homepage(),
        builder: (context) => LoginPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Text(
          "BSK Quiz ...",
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontFamily: "Satisfy",
          ),
        ),
      ),
      
    );
  }
}