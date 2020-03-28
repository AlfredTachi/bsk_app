import 'package:bsk_app/screens/home/more_info_bsk/more_info_bsk.dart';
import 'package:flutter/material.dart';
import 'package:bsk_app/screens/home/home.dart';
import 'package:bsk_app/screens/authenticate/login/login.dart';
import 'package:bsk_app/screens/splash/splash.dart';
import 'package:bsk_app/screens/authenticate/signup/signup.dart';
import 'package:bsk_app/screens/home/profile/profile.dart';
import 'package:bsk_app/screens/home/view_zf_from_onedrive/view_zf_from_onedrive.dart';

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
      case '/viewonedrivepage':
        return MaterialPageRoute(builder: (_) => SummaryDir());
      case '/moreinfopage':
        return MaterialPageRoute(builder: (_) => MoreInfoBsk());
      default:
        return _errorRoute();
    }
  }
}
