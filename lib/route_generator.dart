import 'package:flutter/material.dart';
import 'package:bsk_app/home/home.dart';
import 'package:bsk_app/login/login.dart';
import 'package:bsk_app/splash/splash.dart';

class RouteGenerator {

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('No matching route found!'),
        ),
      );
    });
  }

  static Route<dynamic> generateRoute(RouteSettings settings){
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case '/loginpage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/homepage':
        return MaterialPageRoute(builder: (_) => Homepage());
      default:
        return _errorRoute();
    }
  }
}