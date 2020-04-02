import 'dart:async';

import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(
        '/homepage',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(color: Colors.indigo)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              child: Material(
                color: Colors.grey[400],
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRect(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'images/splash.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    '    Mach dich fit \nfür die BSK Prüfung',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: "Quando"),
                  )
                ],
              ),
            )
          ],
        )
      ],
    )));
  }
}
