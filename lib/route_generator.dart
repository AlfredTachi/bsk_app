import 'package:flutter/material.dart';
import 'package:bsk_app/screens/home/home.dart';
import 'package:bsk_app/screens/login/login.dart';
import 'package:bsk_app/screens/splash/splash.dart';
import 'package:bsk_app/screens/signup/signup.dart';
import 'package:bsk_app/screens/profile/profile.dart';
import 'package:bsk_app/screens/wrapper.dart';

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
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case '/loginpage':
        return MaterialPageRoute(builder: (_) => Loginpage());
      case '/signuppage':
        return MaterialPageRoute(builder: (_) => Signuppage());
      case '/homepage':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/profilepage':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/wrapperpage':
        return MaterialPageRoute(builder: (_) => Wrapper());
      default:
        return _errorRoute();
    }
  }
}