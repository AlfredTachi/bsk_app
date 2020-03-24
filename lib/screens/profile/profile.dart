import 'package:flutter/material.dart';
import 'package:bsk_app/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: 'Quando'),
        ),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.indigo[200], Colors.indigo[500]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(
                  'images/splash.png',
                ),
                radius: 90,
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Taroal',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'taroal@web.de',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'LAST SCORE',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '.../50',
                style: TextStyle(
                    fontFamily: 'Quando',
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  _firebaseAuth.signOut();
                  Navigator.of(context).pushNamed('/loginpage');
                },
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ausloggen',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
